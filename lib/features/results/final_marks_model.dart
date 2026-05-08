import 'package:cloud_firestore/cloud_firestore.dart';

class FinalMarksModel {
  const FinalMarksModel({
    this.id,
    required this.studentId,
    this.placementId,
    required this.studentName,
    required this.registrationNumber,
    required this.program,
    required this.supervisorId,
    required this.supervisorName,
    required this.firstVisitMarks,
    required this.secondVisitMarks,
    required this.companySupervisorMarks,
    required this.totalMarks,
    this.remarks,
    this.submittedAt,
    this.updatedAt,
  });

  final String? id;
  final String studentId;
  final String? placementId;
  final String studentName;
  final String registrationNumber;
  final String program;
  final String supervisorId;
  final String supervisorName;
  final double firstVisitMarks;
  final double secondVisitMarks;
  final double companySupervisorMarks;
  final double totalMarks;
  final String? remarks;
  final DateTime? submittedAt;
  final DateTime? updatedAt;

  static FinalMarksModel fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = doc.data() ?? const <String, dynamic>{};

    DateTime? parseDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      if (value is String) return DateTime.tryParse(value);
      return null;
    }

    double parseMarks(dynamic value) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0;
      return 0;
    }

    return FinalMarksModel(
      id: doc.id,
      studentId: data['studentId'] as String? ?? '',
      placementId: data['placementId'] as String?,
      studentName: data['studentName'] as String? ?? 'Unknown student',
      registrationNumber: data['registrationNumber'] as String? ?? 'N/A',
      program: data['program'] as String? ?? 'N/A',
      supervisorId: data['supervisorId'] as String? ?? '',
      supervisorName: data['supervisorName'] as String? ?? 'Unknown supervisor',
      firstVisitMarks: parseMarks(data['firstVisitMarks']),
      secondVisitMarks: parseMarks(data['secondVisitMarks']),
      companySupervisorMarks: parseMarks(data['companySupervisorMarks']),
      totalMarks: parseMarks(data['totalMarks']),
      remarks: data['remarks'] as String?,
      submittedAt: parseDate(data['submittedAt']),
      updatedAt: parseDate(data['updatedAt']),
    );
  }
}
