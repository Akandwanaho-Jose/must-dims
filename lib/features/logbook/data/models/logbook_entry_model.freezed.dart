// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logbook_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LogbookEntryModel _$LogbookEntryModelFromJson(Map<String, dynamic> json) {
  return _LogbookEntryModel.fromJson(json);
}

/// @nodoc
mixin _$LogbookEntryModel {
  String? get id => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get placementId => throw _privateConstructorUsedError; // Week tracking
  int get weekNumber =>
      throw _privateConstructorUsedError; // 1, 2, 3... up to totalWeeks
  DateTime get weekStartDate => throw _privateConstructorUsedError;
  DateTime get weekEndDate =>
      throw _privateConstructorUsedError; // Student submission
  String get activitiesPerformed => throw _privateConstructorUsedError;
  String? get skillsLearned => throw _privateConstructorUsedError;
  String? get challengesFaced => throw _privateConstructorUsedError;
  double get hoursWorked => throw _privateConstructorUsedError;
  List<String> get attachmentUrls =>
      throw _privateConstructorUsedError; // Photos, documents
  DateTime? get submittedAt =>
      throw _privateConstructorUsedError; // University supervisor review
  bool get isReviewedByUniversitySupervisor =>
      throw _privateConstructorUsedError;
  String? get universitySupervisorComment => throw _privateConstructorUsedError;
  int? get universitySupervisorRating =>
      throw _privateConstructorUsedError; // 1-5 stars
  DateTime? get universityReviewedAt =>
      throw _privateConstructorUsedError; // Company supervisor review - NEW FIELDS
  bool get isReviewedByCompanySupervisor => throw _privateConstructorUsedError;
  String? get companySupervisorComment => throw _privateConstructorUsedError;
  int? get companySupervisorRating =>
      throw _privateConstructorUsedError; // 1-5 stars
  DateTime? get companyReviewedAt =>
      throw _privateConstructorUsedError; // Additional ratings (optional)
  int? get codeQualityRating => throw _privateConstructorUsedError;
  int? get problemSolvingRating => throw _privateConstructorUsedError;
  int? get initiativeRating => throw _privateConstructorUsedError;
  int? get communicationRating => throw _privateConstructorUsedError; // Status
  String get status =>
      throw _privateConstructorUsedError; // draft, submitted, reviewed
// Location tracking (optional)
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError; // Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LogbookEntryModelCopyWith<LogbookEntryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogbookEntryModelCopyWith<$Res> {
  factory $LogbookEntryModelCopyWith(
          LogbookEntryModel value, $Res Function(LogbookEntryModel) then) =
      _$LogbookEntryModelCopyWithImpl<$Res, LogbookEntryModel>;
  @useResult
  $Res call(
      {String? id,
      String studentId,
      String placementId,
      int weekNumber,
      DateTime weekStartDate,
      DateTime weekEndDate,
      String activitiesPerformed,
      String? skillsLearned,
      String? challengesFaced,
      double hoursWorked,
      List<String> attachmentUrls,
      DateTime? submittedAt,
      bool isReviewedByUniversitySupervisor,
      String? universitySupervisorComment,
      int? universitySupervisorRating,
      DateTime? universityReviewedAt,
      bool isReviewedByCompanySupervisor,
      String? companySupervisorComment,
      int? companySupervisorRating,
      DateTime? companyReviewedAt,
      int? codeQualityRating,
      int? problemSolvingRating,
      int? initiativeRating,
      int? communicationRating,
      String status,
      double? latitude,
      double? longitude,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$LogbookEntryModelCopyWithImpl<$Res, $Val extends LogbookEntryModel>
    implements $LogbookEntryModelCopyWith<$Res> {
  _$LogbookEntryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? studentId = null,
    Object? placementId = null,
    Object? weekNumber = null,
    Object? weekStartDate = null,
    Object? weekEndDate = null,
    Object? activitiesPerformed = null,
    Object? skillsLearned = freezed,
    Object? challengesFaced = freezed,
    Object? hoursWorked = null,
    Object? attachmentUrls = null,
    Object? submittedAt = freezed,
    Object? isReviewedByUniversitySupervisor = null,
    Object? universitySupervisorComment = freezed,
    Object? universitySupervisorRating = freezed,
    Object? universityReviewedAt = freezed,
    Object? isReviewedByCompanySupervisor = null,
    Object? companySupervisorComment = freezed,
    Object? companySupervisorRating = freezed,
    Object? companyReviewedAt = freezed,
    Object? codeQualityRating = freezed,
    Object? problemSolvingRating = freezed,
    Object? initiativeRating = freezed,
    Object? communicationRating = freezed,
    Object? status = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      placementId: null == placementId
          ? _value.placementId
          : placementId // ignore: cast_nullable_to_non_nullable
              as String,
      weekNumber: null == weekNumber
          ? _value.weekNumber
          : weekNumber // ignore: cast_nullable_to_non_nullable
              as int,
      weekStartDate: null == weekStartDate
          ? _value.weekStartDate
          : weekStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weekEndDate: null == weekEndDate
          ? _value.weekEndDate
          : weekEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      activitiesPerformed: null == activitiesPerformed
          ? _value.activitiesPerformed
          : activitiesPerformed // ignore: cast_nullable_to_non_nullable
              as String,
      skillsLearned: freezed == skillsLearned
          ? _value.skillsLearned
          : skillsLearned // ignore: cast_nullable_to_non_nullable
              as String?,
      challengesFaced: freezed == challengesFaced
          ? _value.challengesFaced
          : challengesFaced // ignore: cast_nullable_to_non_nullable
              as String?,
      hoursWorked: null == hoursWorked
          ? _value.hoursWorked
          : hoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      attachmentUrls: null == attachmentUrls
          ? _value.attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isReviewedByUniversitySupervisor: null == isReviewedByUniversitySupervisor
          ? _value.isReviewedByUniversitySupervisor
          : isReviewedByUniversitySupervisor // ignore: cast_nullable_to_non_nullable
              as bool,
      universitySupervisorComment: freezed == universitySupervisorComment
          ? _value.universitySupervisorComment
          : universitySupervisorComment // ignore: cast_nullable_to_non_nullable
              as String?,
      universitySupervisorRating: freezed == universitySupervisorRating
          ? _value.universitySupervisorRating
          : universitySupervisorRating // ignore: cast_nullable_to_non_nullable
              as int?,
      universityReviewedAt: freezed == universityReviewedAt
          ? _value.universityReviewedAt
          : universityReviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isReviewedByCompanySupervisor: null == isReviewedByCompanySupervisor
          ? _value.isReviewedByCompanySupervisor
          : isReviewedByCompanySupervisor // ignore: cast_nullable_to_non_nullable
              as bool,
      companySupervisorComment: freezed == companySupervisorComment
          ? _value.companySupervisorComment
          : companySupervisorComment // ignore: cast_nullable_to_non_nullable
              as String?,
      companySupervisorRating: freezed == companySupervisorRating
          ? _value.companySupervisorRating
          : companySupervisorRating // ignore: cast_nullable_to_non_nullable
              as int?,
      companyReviewedAt: freezed == companyReviewedAt
          ? _value.companyReviewedAt
          : companyReviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      codeQualityRating: freezed == codeQualityRating
          ? _value.codeQualityRating
          : codeQualityRating // ignore: cast_nullable_to_non_nullable
              as int?,
      problemSolvingRating: freezed == problemSolvingRating
          ? _value.problemSolvingRating
          : problemSolvingRating // ignore: cast_nullable_to_non_nullable
              as int?,
      initiativeRating: freezed == initiativeRating
          ? _value.initiativeRating
          : initiativeRating // ignore: cast_nullable_to_non_nullable
              as int?,
      communicationRating: freezed == communicationRating
          ? _value.communicationRating
          : communicationRating // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LogbookEntryModelImplCopyWith<$Res>
    implements $LogbookEntryModelCopyWith<$Res> {
  factory _$$LogbookEntryModelImplCopyWith(_$LogbookEntryModelImpl value,
          $Res Function(_$LogbookEntryModelImpl) then) =
      __$$LogbookEntryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String studentId,
      String placementId,
      int weekNumber,
      DateTime weekStartDate,
      DateTime weekEndDate,
      String activitiesPerformed,
      String? skillsLearned,
      String? challengesFaced,
      double hoursWorked,
      List<String> attachmentUrls,
      DateTime? submittedAt,
      bool isReviewedByUniversitySupervisor,
      String? universitySupervisorComment,
      int? universitySupervisorRating,
      DateTime? universityReviewedAt,
      bool isReviewedByCompanySupervisor,
      String? companySupervisorComment,
      int? companySupervisorRating,
      DateTime? companyReviewedAt,
      int? codeQualityRating,
      int? problemSolvingRating,
      int? initiativeRating,
      int? communicationRating,
      String status,
      double? latitude,
      double? longitude,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$LogbookEntryModelImplCopyWithImpl<$Res>
    extends _$LogbookEntryModelCopyWithImpl<$Res, _$LogbookEntryModelImpl>
    implements _$$LogbookEntryModelImplCopyWith<$Res> {
  __$$LogbookEntryModelImplCopyWithImpl(_$LogbookEntryModelImpl _value,
      $Res Function(_$LogbookEntryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? studentId = null,
    Object? placementId = null,
    Object? weekNumber = null,
    Object? weekStartDate = null,
    Object? weekEndDate = null,
    Object? activitiesPerformed = null,
    Object? skillsLearned = freezed,
    Object? challengesFaced = freezed,
    Object? hoursWorked = null,
    Object? attachmentUrls = null,
    Object? submittedAt = freezed,
    Object? isReviewedByUniversitySupervisor = null,
    Object? universitySupervisorComment = freezed,
    Object? universitySupervisorRating = freezed,
    Object? universityReviewedAt = freezed,
    Object? isReviewedByCompanySupervisor = null,
    Object? companySupervisorComment = freezed,
    Object? companySupervisorRating = freezed,
    Object? companyReviewedAt = freezed,
    Object? codeQualityRating = freezed,
    Object? problemSolvingRating = freezed,
    Object? initiativeRating = freezed,
    Object? communicationRating = freezed,
    Object? status = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$LogbookEntryModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      placementId: null == placementId
          ? _value.placementId
          : placementId // ignore: cast_nullable_to_non_nullable
              as String,
      weekNumber: null == weekNumber
          ? _value.weekNumber
          : weekNumber // ignore: cast_nullable_to_non_nullable
              as int,
      weekStartDate: null == weekStartDate
          ? _value.weekStartDate
          : weekStartDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weekEndDate: null == weekEndDate
          ? _value.weekEndDate
          : weekEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      activitiesPerformed: null == activitiesPerformed
          ? _value.activitiesPerformed
          : activitiesPerformed // ignore: cast_nullable_to_non_nullable
              as String,
      skillsLearned: freezed == skillsLearned
          ? _value.skillsLearned
          : skillsLearned // ignore: cast_nullable_to_non_nullable
              as String?,
      challengesFaced: freezed == challengesFaced
          ? _value.challengesFaced
          : challengesFaced // ignore: cast_nullable_to_non_nullable
              as String?,
      hoursWorked: null == hoursWorked
          ? _value.hoursWorked
          : hoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      attachmentUrls: null == attachmentUrls
          ? _value._attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isReviewedByUniversitySupervisor: null == isReviewedByUniversitySupervisor
          ? _value.isReviewedByUniversitySupervisor
          : isReviewedByUniversitySupervisor // ignore: cast_nullable_to_non_nullable
              as bool,
      universitySupervisorComment: freezed == universitySupervisorComment
          ? _value.universitySupervisorComment
          : universitySupervisorComment // ignore: cast_nullable_to_non_nullable
              as String?,
      universitySupervisorRating: freezed == universitySupervisorRating
          ? _value.universitySupervisorRating
          : universitySupervisorRating // ignore: cast_nullable_to_non_nullable
              as int?,
      universityReviewedAt: freezed == universityReviewedAt
          ? _value.universityReviewedAt
          : universityReviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isReviewedByCompanySupervisor: null == isReviewedByCompanySupervisor
          ? _value.isReviewedByCompanySupervisor
          : isReviewedByCompanySupervisor // ignore: cast_nullable_to_non_nullable
              as bool,
      companySupervisorComment: freezed == companySupervisorComment
          ? _value.companySupervisorComment
          : companySupervisorComment // ignore: cast_nullable_to_non_nullable
              as String?,
      companySupervisorRating: freezed == companySupervisorRating
          ? _value.companySupervisorRating
          : companySupervisorRating // ignore: cast_nullable_to_non_nullable
              as int?,
      companyReviewedAt: freezed == companyReviewedAt
          ? _value.companyReviewedAt
          : companyReviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      codeQualityRating: freezed == codeQualityRating
          ? _value.codeQualityRating
          : codeQualityRating // ignore: cast_nullable_to_non_nullable
              as int?,
      problemSolvingRating: freezed == problemSolvingRating
          ? _value.problemSolvingRating
          : problemSolvingRating // ignore: cast_nullable_to_non_nullable
              as int?,
      initiativeRating: freezed == initiativeRating
          ? _value.initiativeRating
          : initiativeRating // ignore: cast_nullable_to_non_nullable
              as int?,
      communicationRating: freezed == communicationRating
          ? _value.communicationRating
          : communicationRating // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LogbookEntryModelImpl implements _LogbookEntryModel {
  const _$LogbookEntryModelImpl(
      {this.id,
      required this.studentId,
      required this.placementId,
      required this.weekNumber,
      required this.weekStartDate,
      required this.weekEndDate,
      required this.activitiesPerformed,
      this.skillsLearned,
      this.challengesFaced,
      required this.hoursWorked,
      final List<String> attachmentUrls = const [],
      this.submittedAt,
      this.isReviewedByUniversitySupervisor = false,
      this.universitySupervisorComment,
      this.universitySupervisorRating,
      this.universityReviewedAt,
      this.isReviewedByCompanySupervisor = false,
      this.companySupervisorComment,
      this.companySupervisorRating,
      this.companyReviewedAt,
      this.codeQualityRating,
      this.problemSolvingRating,
      this.initiativeRating,
      this.communicationRating,
      this.status = 'draft',
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt})
      : _attachmentUrls = attachmentUrls;

  factory _$LogbookEntryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogbookEntryModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String studentId;
  @override
  final String placementId;
// Week tracking
  @override
  final int weekNumber;
// 1, 2, 3... up to totalWeeks
  @override
  final DateTime weekStartDate;
  @override
  final DateTime weekEndDate;
// Student submission
  @override
  final String activitiesPerformed;
  @override
  final String? skillsLearned;
  @override
  final String? challengesFaced;
  @override
  final double hoursWorked;
  final List<String> _attachmentUrls;
  @override
  @JsonKey()
  List<String> get attachmentUrls {
    if (_attachmentUrls is EqualUnmodifiableListView) return _attachmentUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachmentUrls);
  }

// Photos, documents
  @override
  final DateTime? submittedAt;
// University supervisor review
  @override
  @JsonKey()
  final bool isReviewedByUniversitySupervisor;
  @override
  final String? universitySupervisorComment;
  @override
  final int? universitySupervisorRating;
// 1-5 stars
  @override
  final DateTime? universityReviewedAt;
// Company supervisor review - NEW FIELDS
  @override
  @JsonKey()
  final bool isReviewedByCompanySupervisor;
  @override
  final String? companySupervisorComment;
  @override
  final int? companySupervisorRating;
// 1-5 stars
  @override
  final DateTime? companyReviewedAt;
// Additional ratings (optional)
  @override
  final int? codeQualityRating;
  @override
  final int? problemSolvingRating;
  @override
  final int? initiativeRating;
  @override
  final int? communicationRating;
// Status
  @override
  @JsonKey()
  final String status;
// draft, submitted, reviewed
// Location tracking (optional)
  @override
  final double? latitude;
  @override
  final double? longitude;
// Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'LogbookEntryModel(id: $id, studentId: $studentId, placementId: $placementId, weekNumber: $weekNumber, weekStartDate: $weekStartDate, weekEndDate: $weekEndDate, activitiesPerformed: $activitiesPerformed, skillsLearned: $skillsLearned, challengesFaced: $challengesFaced, hoursWorked: $hoursWorked, attachmentUrls: $attachmentUrls, submittedAt: $submittedAt, isReviewedByUniversitySupervisor: $isReviewedByUniversitySupervisor, universitySupervisorComment: $universitySupervisorComment, universitySupervisorRating: $universitySupervisorRating, universityReviewedAt: $universityReviewedAt, isReviewedByCompanySupervisor: $isReviewedByCompanySupervisor, companySupervisorComment: $companySupervisorComment, companySupervisorRating: $companySupervisorRating, companyReviewedAt: $companyReviewedAt, codeQualityRating: $codeQualityRating, problemSolvingRating: $problemSolvingRating, initiativeRating: $initiativeRating, communicationRating: $communicationRating, status: $status, latitude: $latitude, longitude: $longitude, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogbookEntryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.placementId, placementId) ||
                other.placementId == placementId) &&
            (identical(other.weekNumber, weekNumber) ||
                other.weekNumber == weekNumber) &&
            (identical(other.weekStartDate, weekStartDate) ||
                other.weekStartDate == weekStartDate) &&
            (identical(other.weekEndDate, weekEndDate) ||
                other.weekEndDate == weekEndDate) &&
            (identical(other.activitiesPerformed, activitiesPerformed) ||
                other.activitiesPerformed == activitiesPerformed) &&
            (identical(other.skillsLearned, skillsLearned) ||
                other.skillsLearned == skillsLearned) &&
            (identical(other.challengesFaced, challengesFaced) ||
                other.challengesFaced == challengesFaced) &&
            (identical(other.hoursWorked, hoursWorked) ||
                other.hoursWorked == hoursWorked) &&
            const DeepCollectionEquality()
                .equals(other._attachmentUrls, _attachmentUrls) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.isReviewedByUniversitySupervisor,
                    isReviewedByUniversitySupervisor) ||
                other.isReviewedByUniversitySupervisor ==
                    isReviewedByUniversitySupervisor) &&
            (identical(other.universitySupervisorComment, universitySupervisorComment) ||
                other.universitySupervisorComment ==
                    universitySupervisorComment) &&
            (identical(other.universitySupervisorRating, universitySupervisorRating) ||
                other.universitySupervisorRating ==
                    universitySupervisorRating) &&
            (identical(other.universityReviewedAt, universityReviewedAt) ||
                other.universityReviewedAt == universityReviewedAt) &&
            (identical(other.isReviewedByCompanySupervisor, isReviewedByCompanySupervisor) ||
                other.isReviewedByCompanySupervisor ==
                    isReviewedByCompanySupervisor) &&
            (identical(other.companySupervisorComment, companySupervisorComment) ||
                other.companySupervisorComment == companySupervisorComment) &&
            (identical(other.companySupervisorRating, companySupervisorRating) ||
                other.companySupervisorRating == companySupervisorRating) &&
            (identical(other.companyReviewedAt, companyReviewedAt) ||
                other.companyReviewedAt == companyReviewedAt) &&
            (identical(other.codeQualityRating, codeQualityRating) ||
                other.codeQualityRating == codeQualityRating) &&
            (identical(other.problemSolvingRating, problemSolvingRating) ||
                other.problemSolvingRating == problemSolvingRating) &&
            (identical(other.initiativeRating, initiativeRating) ||
                other.initiativeRating == initiativeRating) &&
            (identical(other.communicationRating, communicationRating) ||
                other.communicationRating == communicationRating) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.latitude, latitude) || other.latitude == latitude) &&
            (identical(other.longitude, longitude) || other.longitude == longitude) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        studentId,
        placementId,
        weekNumber,
        weekStartDate,
        weekEndDate,
        activitiesPerformed,
        skillsLearned,
        challengesFaced,
        hoursWorked,
        const DeepCollectionEquality().hash(_attachmentUrls),
        submittedAt,
        isReviewedByUniversitySupervisor,
        universitySupervisorComment,
        universitySupervisorRating,
        universityReviewedAt,
        isReviewedByCompanySupervisor,
        companySupervisorComment,
        companySupervisorRating,
        companyReviewedAt,
        codeQualityRating,
        problemSolvingRating,
        initiativeRating,
        communicationRating,
        status,
        latitude,
        longitude,
        createdAt,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LogbookEntryModelImplCopyWith<_$LogbookEntryModelImpl> get copyWith =>
      __$$LogbookEntryModelImplCopyWithImpl<_$LogbookEntryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LogbookEntryModelImplToJson(
      this,
    );
  }
}

abstract class _LogbookEntryModel implements LogbookEntryModel {
  const factory _LogbookEntryModel(
      {final String? id,
      required final String studentId,
      required final String placementId,
      required final int weekNumber,
      required final DateTime weekStartDate,
      required final DateTime weekEndDate,
      required final String activitiesPerformed,
      final String? skillsLearned,
      final String? challengesFaced,
      required final double hoursWorked,
      final List<String> attachmentUrls,
      final DateTime? submittedAt,
      final bool isReviewedByUniversitySupervisor,
      final String? universitySupervisorComment,
      final int? universitySupervisorRating,
      final DateTime? universityReviewedAt,
      final bool isReviewedByCompanySupervisor,
      final String? companySupervisorComment,
      final int? companySupervisorRating,
      final DateTime? companyReviewedAt,
      final int? codeQualityRating,
      final int? problemSolvingRating,
      final int? initiativeRating,
      final int? communicationRating,
      final String status,
      final double? latitude,
      final double? longitude,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$LogbookEntryModelImpl;

  factory _LogbookEntryModel.fromJson(Map<String, dynamic> json) =
      _$LogbookEntryModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get studentId;
  @override
  String get placementId;
  @override // Week tracking
  int get weekNumber;
  @override // 1, 2, 3... up to totalWeeks
  DateTime get weekStartDate;
  @override
  DateTime get weekEndDate;
  @override // Student submission
  String get activitiesPerformed;
  @override
  String? get skillsLearned;
  @override
  String? get challengesFaced;
  @override
  double get hoursWorked;
  @override
  List<String> get attachmentUrls;
  @override // Photos, documents
  DateTime? get submittedAt;
  @override // University supervisor review
  bool get isReviewedByUniversitySupervisor;
  @override
  String? get universitySupervisorComment;
  @override
  int? get universitySupervisorRating;
  @override // 1-5 stars
  DateTime? get universityReviewedAt;
  @override // Company supervisor review - NEW FIELDS
  bool get isReviewedByCompanySupervisor;
  @override
  String? get companySupervisorComment;
  @override
  int? get companySupervisorRating;
  @override // 1-5 stars
  DateTime? get companyReviewedAt;
  @override // Additional ratings (optional)
  int? get codeQualityRating;
  @override
  int? get problemSolvingRating;
  @override
  int? get initiativeRating;
  @override
  int? get communicationRating;
  @override // Status
  String get status;
  @override // draft, submitted, reviewed
// Location tracking (optional)
  double? get latitude;
  @override
  double? get longitude;
  @override // Timestamps
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$LogbookEntryModelImplCopyWith<_$LogbookEntryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
