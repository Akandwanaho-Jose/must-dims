import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logbook_entry_model.freezed.dart';
part 'logbook_entry_model.g.dart';

@freezed
class LogbookEntryModel with _$LogbookEntryModel {
  const factory LogbookEntryModel({
    String? id,
    required String studentRefPath,
    required String placementRefPath,
    required String supervisorId,
    required DateTime date,
    required int dayNumber,
    required String tasksPerformed,
    String? challenges,
    String? skillsLearned,
    required double hoursWorked,
    @Default('pending') String status,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? latitude,
    double? longitude,
    String? photoUrl,
    String? supervisorComment,
    DateTime? approvedAt,
  }) = _LogbookEntryModel;

  factory LogbookEntryModel.fromJson(Map<String, dynamic> json) =>
      _$LogbookEntryModelFromJson(json);

  // ── Timestamp-safe fromFirestore (static factory)
  static LogbookEntryModel fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = doc.data() ?? {};

    // Helper to safely convert Timestamp / string to DateTime
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      if (value is String) return DateTime.tryParse(value);
      return null;
    }

    return LogbookEntryModel.fromJson({
      ...data,
      'id': doc.id,
      'date': parseDate(data['date'])?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'createdAt': parseDate(data['createdAt'])?.toIso8601String(),
      'updatedAt': parseDate(data['updatedAt'])?.toIso8601String(),
      'approvedAt': parseDate(data['approvedAt'])?.toIso8601String(),
    });
  }
}

// ── Extension for toFirestore (instance method)
extension LogbookEntryModelFirestore on LogbookEntryModel {
  Map<String, dynamic> toFirestore() {
    return {
      'studentRefPath': studentRefPath,
      'placementRefPath': placementRefPath,
      'supervisorId': supervisorId,
      'date': Timestamp.fromDate(date),
      'dayNumber': dayNumber,
      'tasksPerformed': tasksPerformed,
      'challenges': challenges,
      'skillsLearned': skillsLearned,
      'hoursWorked': hoursWorked,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'photoUrl': photoUrl,
      'supervisorComment': supervisorComment,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      if (approvedAt != null) 'approvedAt': Timestamp.fromDate(approvedAt!),
    };
  }
}