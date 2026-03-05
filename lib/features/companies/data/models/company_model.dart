import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  const factory CompanyModel({
    required String id,
    required String name,
    required String industry,
    required String location,
    
    // Contact information
    String? contactEmail,
    String? contactPhone,
    String? website,
    
    // Visual
    String? logoUrl,
    String? description,
    
    // Intern capacity tracking - NEW
    @Default(0) int maxInterns, // How many interns they can take (0 = unlimited)
    @Default(0) int currentInterns, // Current number of active interns
    
    // Preferred programs - NEW
    @Default([]) List<String> preferredPrograms, // e.g., ["Computer Science", "IT"]
    
    // Company supervisor IDs - NEW
    @Default([]) List<String> companySupervisorIds, // UIDs of company supervisors
    
    // Status
    @Default(true) bool isActive,
    @Default(true) bool acceptingInterns, // NEW - Can toggle to stop accepting applications
    
    // Additional info - NEW
    String? address,
    String? city,
    String? country,
    String? postalCode,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  static CompanyModel fromFirestore(
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

    return CompanyModel.fromJson({
      ...data,
      'id': doc.id,
      'createdAt': parseDate(data['createdAt'])?.toIso8601String(),
      'updatedAt': parseDate(data['updatedAt'])?.toIso8601String(),
    });
  }

  static Map<String, dynamic> toFirestore(
    CompanyModel company,
    SetOptions? options,
  ) {
    final json = company.toJson();
    json.remove('id'); // Don't store ID in document

    if (company.createdAt != null) {
      json['createdAt'] = Timestamp.fromDate(company.createdAt!);
    }
    if (company.updatedAt != null) {
      json['updatedAt'] = Timestamp.fromDate(company.updatedAt!);
    }

    return json;
  }
}