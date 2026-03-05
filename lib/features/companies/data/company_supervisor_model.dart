import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_supervisor_model.freezed.dart';
part 'company_supervisor_model.g.dart';

@freezed
class CompanySupervisorModel with _$CompanySupervisorModel {
  const factory CompanySupervisorModel({
    required String uid,
    required String fullName,
    required String email,
    required String companyId,
    String? companyName, // Denormalized for quick access
    String? position,
    String? phoneNumber,
    String? photoUrl,
    
    // Access control
    @Default(true) bool isActive,
    @Default(false) bool emailVerified,
    
    // Student management
    @Default([]) List<String> assignedStudentIds,
    @Default(0) int currentLoad,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? lastLoginAt,
    DateTime? updatedAt,
  }) = _CompanySupervisorModel;

  factory CompanySupervisorModel.fromJson(Map<String, dynamic> json) =>
      _$CompanySupervisorModelFromJson(json);

  // Firestore converters
  static CompanySupervisorModel fromFirestore(
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

    return CompanySupervisorModel.fromJson({
      ...data,
      'uid': doc.id,
      'createdAt': parseDate(data['createdAt'])?.toIso8601String(),
      'lastLoginAt': parseDate(data['lastLoginAt'])?.toIso8601String(),
      'updatedAt': parseDate(data['updatedAt'])?.toIso8601String(),
    });
  }

  static Map<String, dynamic> toFirestore(
    CompanySupervisorModel model,
    SetOptions? options,
  ) {
    final json = model.toJson();
    json.remove('uid'); // UID is document ID

    if (model.createdAt != null) {
      json['createdAt'] = Timestamp.fromDate(model.createdAt!);
    }
    if (model.lastLoginAt != null) {
      json['lastLoginAt'] = Timestamp.fromDate(model.lastLoginAt!);
    }
    if (model.updatedAt != null) {
      json['updatedAt'] = Timestamp.fromDate(model.updatedAt!);
    }

    return json;
  }
}