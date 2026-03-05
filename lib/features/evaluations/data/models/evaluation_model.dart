import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'evaluation_model.freezed.dart';
part 'evaluation_model.g.dart';

enum EvaluationType {
  companySupervisor,    // Final evaluation from company
  universitySupervisor, // Final evaluation from university
}

@freezed
class EvaluationModel with _$EvaluationModel {
  const factory EvaluationModel({
    String? id,
    required String placementId,
    required String studentId,
    required EvaluationType evaluatorType,
    required String evaluatorId,
    String? evaluatorName,
    
    // Overall marks
    required double finalMarks, // Out of 100
    
    // Category ratings (1-5 stars each)
    required double technicalSkillsRating,
    required double workEthicRating,
    required double communicationRating,
    required double problemSolvingRating,
    required double initiativeRating,
    required double teamworkRating,
    
    // Attendance (for company supervisor)
    int? daysPresent,
    int? daysAbsent,
    int? totalWorkingDays,
    
    // Recommendations
    String? overallComments,
    String? strengthsHighlighted,
    String? areasForImprovement,
    String? recommendationsForFutureInterns,
    
    // Hiring potential (for company supervisor)
    bool? wouldHireAgain,
    String? hiringConditions,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? submittedAt,
  }) = _EvaluationModel;

  factory EvaluationModel.fromJson(Map<String, dynamic> json) =>
      _$EvaluationModelFromJson(json);

  // Firestore converters
  static EvaluationModel fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = doc.data();
    if (data == null) {
      throw Exception('Document data is null');
    }

    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      if (value is String) return DateTime.tryParse(value);
      return null;
    }

    return EvaluationModel.fromJson({
      ...data,
      'id': doc.id,
      'createdAt': parseDate(data['createdAt'])?.toIso8601String(),
      'submittedAt': parseDate(data['submittedAt'])?.toIso8601String(),
    });
  }

  static Map<String, dynamic> toFirestore(
    EvaluationModel evaluation,
    SetOptions? options,
  ) {
    final json = evaluation.toJson();
    json.remove('id');

    if (evaluation.createdAt != null) {
      json['createdAt'] = Timestamp.fromDate(evaluation.createdAt!);
    }
    if (evaluation.submittedAt != null) {
      json['submittedAt'] = Timestamp.fromDate(evaluation.submittedAt!);
    }

    // Convert enum to string
    json['evaluatorType'] = evaluation.evaluatorType.name;

    return json;
  }
}