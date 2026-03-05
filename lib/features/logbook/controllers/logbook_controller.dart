import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/models/daily_logbook_entry_model.dart';
import '../data/models/weekly_logbook_summary_model.dart';

// ============================================================================
// PROVIDERS
// ============================================================================

final logbookControllerProvider = Provider((ref) => LogbookController(ref));

// Daily entries for current student
final dailyEntriesProvider = StreamProvider<List<DailyLogbookEntryModel>>((ref) {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('dailyLogbookEntries')
      .where('studentId', isEqualTo: userId)
      .orderBy('date', descending: true)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs
            .map((doc) => DailyLogbookEntryModel.fromFirestore(doc, null))
            .toList();
      });
});

// Weekly summaries for current student
final weeklySummariesProvider = StreamProvider<List<WeeklyLogbookSummaryModel>>((ref) {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  if (userId == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('weeklyLogbookSummaries')
      .where('studentId', isEqualTo: userId)
      .orderBy('weekNumber', descending: true)
      .snapshots()
      .map((snapshot) {
        return snapshot.docs
            .map((doc) => WeeklyLogbookSummaryModel.fromFirestore(doc, null))
            .toList();
      });
});

// Daily entries for a specific week
final dailyEntriesForWeekProvider = StreamProvider.family<List<DailyLogbookEntryModel>, int>(
  (ref, weekNumber) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    // Calculate week date range based on weekNumber
    // This is a simplified version - you may need to adjust based on placement start date
    return FirebaseFirestore.instance
        .collection('dailyLogbookEntries')
        .where('studentId', isEqualTo: userId)
        .orderBy('dayNumber')
        .snapshots()
        .map((snapshot) {
          final allEntries = snapshot.docs
              .map((doc) => DailyLogbookEntryModel.fromFirestore(doc, null))
              .toList();
          
          // Filter entries for this week (5 days per week)
          final startDay = (weekNumber - 1) * 5 + 1;
          final endDay = weekNumber * 5;
          
          return allEntries.where((entry) {
            return entry.dayNumber >= startDay && entry.dayNumber <= endDay;
          }).toList();
        });
  },
);

// Pending weekly reviews count
final pendingWeeklyReviewsProvider = Provider<int>((ref) {
  final summaries = ref.watch(weeklySummariesProvider).value ?? [];
  return summaries.where((s) {
    return s.status == 'submitted' && !s.isReviewedByCompanySupervisor;
  }).length;
});

// ============================================================================
// CONTROLLER
// ============================================================================

class LogbookController {
  final Ref _ref;
  LogbookController(this._ref);

  FirebaseFirestore get _db => FirebaseFirestore.instance;

  // ══════════════════════════════════════════════════════════════════════════
  // DAILY ENTRIES
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> submitDailyEntry(DailyLogbookEntryModel entry) async {
    try {
      await _db.collection('dailyLogbookEntries').add(
        entry.copyWith(
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ).toFirestore(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDailyEntry(String entryId, DailyLogbookEntryModel entry) async {
    try {
      await _db.collection('dailyLogbookEntries').doc(entryId).update(
        entry.copyWith(updatedAt: DateTime.now()).toFirestore(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteDailyEntry(String entryId) async {
    try {
      await _db.collection('dailyLogbookEntries').doc(entryId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getNextDayNumber(String studentId) async {
    try {
      final snapshot = await _db
          .collection('dailyLogbookEntries')
          .where('studentId', isEqualTo: studentId)
          .orderBy('dayNumber', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return 1;

      final lastEntry = DailyLogbookEntryModel.fromFirestore(snapshot.docs.first, null);
      return lastEntry.dayNumber + 1;
    } catch (e) {
      return 1;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // WEEKLY SUMMARIES
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> submitWeeklySummary(WeeklyLogbookSummaryModel summary) async {
    try {
      await _db.collection('weeklyLogbookSummaries').add(
        summary.copyWith(
          status: 'submitted',
          submittedAt: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ).toFirestore(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateWeeklySummary(String summaryId, WeeklyLogbookSummaryModel summary) async {
    try {
      await _db.collection('weeklyLogbookSummaries').doc(summaryId).update(
        summary.copyWith(updatedAt: DateTime.now()).toFirestore(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteWeeklySummary(String summaryId) async {
    try {
      await _db.collection('weeklyLogbookSummaries').doc(summaryId).delete();
    } catch (e) {
      rethrow;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // SUPERVISOR REVIEW
  // ══════════════════════════════════════════════════════════════════════════

  Future<void> submitCompanyReview({
    required String summaryId,
    required String comment,
    required double rating,
  }) async {
    try {
      await _db.collection('weeklyLogbookSummaries').doc(summaryId).update({
        'isReviewedByCompanySupervisor': true,
        'companySupervisorComment': comment,
        'companySupervisorRating': rating,
        'companyReviewedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> submitUniversityReview({
    required String summaryId,
    required String comment,
    required double rating,
  }) async {
    try {
      await _db.collection('weeklyLogbookSummaries').doc(summaryId).update({
        'isReviewedByUniversitySupervisor': true,
        'universitySupervisorComment': comment,
        'universitySupervisorRating': rating,
        'universityReviewedAt': FieldValue.serverTimestamp(),
        'status': 'reviewed',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  // ══════════════════════════════════════════════════════════════════════════
  // HELPER METHODS
  // ══════════════════════════════════════════════════════════════════════════

  Future<Map<String, dynamic>> compileDailyEntriesForWeek(int weekNumber) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) throw Exception('User not authenticated');

      // Get daily entries for this week
      final startDay = (weekNumber - 1) * 5 + 1;
      final endDay = weekNumber * 5;

      final snapshot = await _db
          .collection('dailyLogbookEntries')
          .where('studentId', isEqualTo: userId)
          .where('dayNumber', isGreaterThanOrEqualTo: startDay)
          .where('dayNumber', isLessThanOrEqualTo: endDay)
          .orderBy('dayNumber')
          .get();

      final entries = snapshot.docs
          .map((doc) => DailyLogbookEntryModel.fromFirestore(doc, null))
          .toList();

      if (entries.isEmpty) {
        throw Exception('No daily entries found for week $weekNumber');
      }

      // Compile data
      final totalHours = entries.fold<double>(
        0.0,
        (sum, entry) => sum + entry.hoursWorked,
      );

      final allTasks = entries
          .map((e) => '• Day ${e.dayNumber}: ${e.tasksPerformed}')
          .join('\n');

      final allChallenges = entries
          .where((e) => e.challenges != null && e.challenges!.isNotEmpty)
          .map((e) => '• ${e.challenges}')
          .join('\n');

      final allSkills = entries
          .where((e) => e.skillsLearned != null && e.skillsLearned!.isNotEmpty)
          .map((e) => '• ${e.skillsLearned}')
          .join('\n');

      return {
        'dailyEntryIds': entries.map((e) => e.id!).toList(),
        'totalHours': totalHours,
        'compiledTasks': allTasks,
        'compiledChallenges': allChallenges.isEmpty ? null : allChallenges,
        'compiledSkills': allSkills.isEmpty ? null : allSkills,
        'weekStartDate': entries.first.date,
        'weekEndDate': entries.last.date,
      };
    } catch (e) {
      rethrow;
    }
  }
}