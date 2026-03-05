import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_logbook_entry_model.freezed.dart';
part 'daily_logbook_entry_model.g.dart';

@freezed
class DailyLogbookEntryModel with _$DailyLogbookEntryModel {
  const factory DailyLogbookEntryModel({
    String? id,
    required String studentId,
    required String placementId,
    required DateTime date,
    required int dayNumber,
    required String tasksPerformed,
    required double hoursWorked,
    String? challenges,
    String? skillsLearned,
    String? notes,
    @Default([]) List<String> attachmentUrls,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DailyLogbookEntryModel;

  factory DailyLogbookEntryModel.fromJson(Map<String, dynamic> json) =>
      _$DailyLogbookEntryModelFromJson(json);

  factory DailyLogbookEntryModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return DailyLogbookEntryModel(
      id: snapshot.id,
      studentId: data['studentId'] as String,
      placementId: data['placementId'] as String,
      date: (data['date'] as Timestamp).toDate(),
      dayNumber: data['dayNumber'] as int,
      tasksPerformed: data['tasksPerformed'] as String,
      hoursWorked: (data['hoursWorked'] as num).toDouble(),
      challenges: data['challenges'] as String?,
      skillsLearned: data['skillsLearned'] as String?,
      notes: data['notes'] as String?,
      attachmentUrls: data['attachmentUrls'] != null
          ? List<String>.from(data['attachmentUrls'] as List)
          : [],
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }
}

extension DailyLogbookEntryModelX on DailyLogbookEntryModel {
  Map<String, dynamic> toFirestore() {
    return {
      'studentId': studentId,
      'placementId': placementId,
      'date': Timestamp.fromDate(date),
      'dayNumber': dayNumber,
      'tasksPerformed': tasksPerformed,
      'hoursWorked': hoursWorked,
      'challenges': challenges,
      'skillsLearned': skillsLearned,
      'notes': notes,
      'attachmentUrls': attachmentUrls,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}