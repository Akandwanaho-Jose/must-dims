// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_logbook_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeeklyLogbookSummaryModel _$WeeklyLogbookSummaryModelFromJson(
    Map<String, dynamic> json) {
  return _WeeklyLogbookSummaryModel.fromJson(json);
}

/// @nodoc
mixin _$WeeklyLogbookSummaryModel {
  String? get id => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get placementId => throw _privateConstructorUsedError;
  int get weekNumber => throw _privateConstructorUsedError;
  DateTime get weekStartDate => throw _privateConstructorUsedError;
  DateTime get weekEndDate =>
      throw _privateConstructorUsedError; // Weekly Overview (compiled by student)
  String get weeklyOverview => throw _privateConstructorUsedError;
  double get totalHoursWorked => throw _privateConstructorUsedError;
  String? get keyAccomplishments => throw _privateConstructorUsedError;
  String? get challengesSummary => throw _privateConstructorUsedError;
  String? get skillsAcquired => throw _privateConstructorUsedError;
  String? get lessonsLearned =>
      throw _privateConstructorUsedError; // References to daily entries
  List<String> get dailyEntryIds =>
      throw _privateConstructorUsedError; // Company Supervisor Review
  bool get isReviewedByCompanySupervisor => throw _privateConstructorUsedError;
  String? get companySupervisorComment => throw _privateConstructorUsedError;
  double? get companySupervisorRating => throw _privateConstructorUsedError;
  DateTime? get companyReviewedAt =>
      throw _privateConstructorUsedError; // University Supervisor Review
  bool get isReviewedByUniversitySupervisor =>
      throw _privateConstructorUsedError;
  String? get universitySupervisorComment => throw _privateConstructorUsedError;
  double? get universitySupervisorRating => throw _privateConstructorUsedError;
  DateTime? get universityReviewedAt =>
      throw _privateConstructorUsedError; // Status
  String get status =>
      throw _privateConstructorUsedError; // draft, submitted, reviewed
  DateTime? get submittedAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeeklyLogbookSummaryModelCopyWith<WeeklyLogbookSummaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyLogbookSummaryModelCopyWith<$Res> {
  factory $WeeklyLogbookSummaryModelCopyWith(WeeklyLogbookSummaryModel value,
          $Res Function(WeeklyLogbookSummaryModel) then) =
      _$WeeklyLogbookSummaryModelCopyWithImpl<$Res, WeeklyLogbookSummaryModel>;
  @useResult
  $Res call(
      {String? id,
      String studentId,
      String placementId,
      int weekNumber,
      DateTime weekStartDate,
      DateTime weekEndDate,
      String weeklyOverview,
      double totalHoursWorked,
      String? keyAccomplishments,
      String? challengesSummary,
      String? skillsAcquired,
      String? lessonsLearned,
      List<String> dailyEntryIds,
      bool isReviewedByCompanySupervisor,
      String? companySupervisorComment,
      double? companySupervisorRating,
      DateTime? companyReviewedAt,
      bool isReviewedByUniversitySupervisor,
      String? universitySupervisorComment,
      double? universitySupervisorRating,
      DateTime? universityReviewedAt,
      String status,
      DateTime? submittedAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$WeeklyLogbookSummaryModelCopyWithImpl<$Res,
        $Val extends WeeklyLogbookSummaryModel>
    implements $WeeklyLogbookSummaryModelCopyWith<$Res> {
  _$WeeklyLogbookSummaryModelCopyWithImpl(this._value, this._then);

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
    Object? weeklyOverview = null,
    Object? totalHoursWorked = null,
    Object? keyAccomplishments = freezed,
    Object? challengesSummary = freezed,
    Object? skillsAcquired = freezed,
    Object? lessonsLearned = freezed,
    Object? dailyEntryIds = null,
    Object? isReviewedByCompanySupervisor = null,
    Object? companySupervisorComment = freezed,
    Object? companySupervisorRating = freezed,
    Object? companyReviewedAt = freezed,
    Object? isReviewedByUniversitySupervisor = null,
    Object? universitySupervisorComment = freezed,
    Object? universitySupervisorRating = freezed,
    Object? universityReviewedAt = freezed,
    Object? status = null,
    Object? submittedAt = freezed,
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
      weeklyOverview: null == weeklyOverview
          ? _value.weeklyOverview
          : weeklyOverview // ignore: cast_nullable_to_non_nullable
              as String,
      totalHoursWorked: null == totalHoursWorked
          ? _value.totalHoursWorked
          : totalHoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      keyAccomplishments: freezed == keyAccomplishments
          ? _value.keyAccomplishments
          : keyAccomplishments // ignore: cast_nullable_to_non_nullable
              as String?,
      challengesSummary: freezed == challengesSummary
          ? _value.challengesSummary
          : challengesSummary // ignore: cast_nullable_to_non_nullable
              as String?,
      skillsAcquired: freezed == skillsAcquired
          ? _value.skillsAcquired
          : skillsAcquired // ignore: cast_nullable_to_non_nullable
              as String?,
      lessonsLearned: freezed == lessonsLearned
          ? _value.lessonsLearned
          : lessonsLearned // ignore: cast_nullable_to_non_nullable
              as String?,
      dailyEntryIds: null == dailyEntryIds
          ? _value.dailyEntryIds
          : dailyEntryIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
              as double?,
      companyReviewedAt: freezed == companyReviewedAt
          ? _value.companyReviewedAt
          : companyReviewedAt // ignore: cast_nullable_to_non_nullable
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
              as double?,
      universityReviewedAt: freezed == universityReviewedAt
          ? _value.universityReviewedAt
          : universityReviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
abstract class _$$WeeklyLogbookSummaryModelImplCopyWith<$Res>
    implements $WeeklyLogbookSummaryModelCopyWith<$Res> {
  factory _$$WeeklyLogbookSummaryModelImplCopyWith(
          _$WeeklyLogbookSummaryModelImpl value,
          $Res Function(_$WeeklyLogbookSummaryModelImpl) then) =
      __$$WeeklyLogbookSummaryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String studentId,
      String placementId,
      int weekNumber,
      DateTime weekStartDate,
      DateTime weekEndDate,
      String weeklyOverview,
      double totalHoursWorked,
      String? keyAccomplishments,
      String? challengesSummary,
      String? skillsAcquired,
      String? lessonsLearned,
      List<String> dailyEntryIds,
      bool isReviewedByCompanySupervisor,
      String? companySupervisorComment,
      double? companySupervisorRating,
      DateTime? companyReviewedAt,
      bool isReviewedByUniversitySupervisor,
      String? universitySupervisorComment,
      double? universitySupervisorRating,
      DateTime? universityReviewedAt,
      String status,
      DateTime? submittedAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$WeeklyLogbookSummaryModelImplCopyWithImpl<$Res>
    extends _$WeeklyLogbookSummaryModelCopyWithImpl<$Res,
        _$WeeklyLogbookSummaryModelImpl>
    implements _$$WeeklyLogbookSummaryModelImplCopyWith<$Res> {
  __$$WeeklyLogbookSummaryModelImplCopyWithImpl(
      _$WeeklyLogbookSummaryModelImpl _value,
      $Res Function(_$WeeklyLogbookSummaryModelImpl) _then)
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
    Object? weeklyOverview = null,
    Object? totalHoursWorked = null,
    Object? keyAccomplishments = freezed,
    Object? challengesSummary = freezed,
    Object? skillsAcquired = freezed,
    Object? lessonsLearned = freezed,
    Object? dailyEntryIds = null,
    Object? isReviewedByCompanySupervisor = null,
    Object? companySupervisorComment = freezed,
    Object? companySupervisorRating = freezed,
    Object? companyReviewedAt = freezed,
    Object? isReviewedByUniversitySupervisor = null,
    Object? universitySupervisorComment = freezed,
    Object? universitySupervisorRating = freezed,
    Object? universityReviewedAt = freezed,
    Object? status = null,
    Object? submittedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$WeeklyLogbookSummaryModelImpl(
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
      weeklyOverview: null == weeklyOverview
          ? _value.weeklyOverview
          : weeklyOverview // ignore: cast_nullable_to_non_nullable
              as String,
      totalHoursWorked: null == totalHoursWorked
          ? _value.totalHoursWorked
          : totalHoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      keyAccomplishments: freezed == keyAccomplishments
          ? _value.keyAccomplishments
          : keyAccomplishments // ignore: cast_nullable_to_non_nullable
              as String?,
      challengesSummary: freezed == challengesSummary
          ? _value.challengesSummary
          : challengesSummary // ignore: cast_nullable_to_non_nullable
              as String?,
      skillsAcquired: freezed == skillsAcquired
          ? _value.skillsAcquired
          : skillsAcquired // ignore: cast_nullable_to_non_nullable
              as String?,
      lessonsLearned: freezed == lessonsLearned
          ? _value.lessonsLearned
          : lessonsLearned // ignore: cast_nullable_to_non_nullable
              as String?,
      dailyEntryIds: null == dailyEntryIds
          ? _value._dailyEntryIds
          : dailyEntryIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
              as double?,
      companyReviewedAt: freezed == companyReviewedAt
          ? _value.companyReviewedAt
          : companyReviewedAt // ignore: cast_nullable_to_non_nullable
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
              as double?,
      universityReviewedAt: freezed == universityReviewedAt
          ? _value.universityReviewedAt
          : universityReviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
class _$WeeklyLogbookSummaryModelImpl implements _WeeklyLogbookSummaryModel {
  const _$WeeklyLogbookSummaryModelImpl(
      {this.id,
      required this.studentId,
      required this.placementId,
      required this.weekNumber,
      required this.weekStartDate,
      required this.weekEndDate,
      required this.weeklyOverview,
      required this.totalHoursWorked,
      this.keyAccomplishments,
      this.challengesSummary,
      this.skillsAcquired,
      this.lessonsLearned,
      final List<String> dailyEntryIds = const [],
      this.isReviewedByCompanySupervisor = false,
      this.companySupervisorComment,
      this.companySupervisorRating,
      this.companyReviewedAt,
      this.isReviewedByUniversitySupervisor = false,
      this.universitySupervisorComment,
      this.universitySupervisorRating,
      this.universityReviewedAt,
      this.status = 'draft',
      this.submittedAt,
      this.createdAt,
      this.updatedAt})
      : _dailyEntryIds = dailyEntryIds;

  factory _$WeeklyLogbookSummaryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyLogbookSummaryModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String studentId;
  @override
  final String placementId;
  @override
  final int weekNumber;
  @override
  final DateTime weekStartDate;
  @override
  final DateTime weekEndDate;
// Weekly Overview (compiled by student)
  @override
  final String weeklyOverview;
  @override
  final double totalHoursWorked;
  @override
  final String? keyAccomplishments;
  @override
  final String? challengesSummary;
  @override
  final String? skillsAcquired;
  @override
  final String? lessonsLearned;
// References to daily entries
  final List<String> _dailyEntryIds;
// References to daily entries
  @override
  @JsonKey()
  List<String> get dailyEntryIds {
    if (_dailyEntryIds is EqualUnmodifiableListView) return _dailyEntryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dailyEntryIds);
  }

// Company Supervisor Review
  @override
  @JsonKey()
  final bool isReviewedByCompanySupervisor;
  @override
  final String? companySupervisorComment;
  @override
  final double? companySupervisorRating;
  @override
  final DateTime? companyReviewedAt;
// University Supervisor Review
  @override
  @JsonKey()
  final bool isReviewedByUniversitySupervisor;
  @override
  final String? universitySupervisorComment;
  @override
  final double? universitySupervisorRating;
  @override
  final DateTime? universityReviewedAt;
// Status
  @override
  @JsonKey()
  final String status;
// draft, submitted, reviewed
  @override
  final DateTime? submittedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'WeeklyLogbookSummaryModel(id: $id, studentId: $studentId, placementId: $placementId, weekNumber: $weekNumber, weekStartDate: $weekStartDate, weekEndDate: $weekEndDate, weeklyOverview: $weeklyOverview, totalHoursWorked: $totalHoursWorked, keyAccomplishments: $keyAccomplishments, challengesSummary: $challengesSummary, skillsAcquired: $skillsAcquired, lessonsLearned: $lessonsLearned, dailyEntryIds: $dailyEntryIds, isReviewedByCompanySupervisor: $isReviewedByCompanySupervisor, companySupervisorComment: $companySupervisorComment, companySupervisorRating: $companySupervisorRating, companyReviewedAt: $companyReviewedAt, isReviewedByUniversitySupervisor: $isReviewedByUniversitySupervisor, universitySupervisorComment: $universitySupervisorComment, universitySupervisorRating: $universitySupervisorRating, universityReviewedAt: $universityReviewedAt, status: $status, submittedAt: $submittedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyLogbookSummaryModelImpl &&
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
            (identical(other.weeklyOverview, weeklyOverview) ||
                other.weeklyOverview == weeklyOverview) &&
            (identical(other.totalHoursWorked, totalHoursWorked) ||
                other.totalHoursWorked == totalHoursWorked) &&
            (identical(other.keyAccomplishments, keyAccomplishments) ||
                other.keyAccomplishments == keyAccomplishments) &&
            (identical(other.challengesSummary, challengesSummary) ||
                other.challengesSummary == challengesSummary) &&
            (identical(other.skillsAcquired, skillsAcquired) ||
                other.skillsAcquired == skillsAcquired) &&
            (identical(other.lessonsLearned, lessonsLearned) ||
                other.lessonsLearned == lessonsLearned) &&
            const DeepCollectionEquality()
                .equals(other._dailyEntryIds, _dailyEntryIds) &&
            (identical(other.isReviewedByCompanySupervisor, isReviewedByCompanySupervisor) ||
                other.isReviewedByCompanySupervisor ==
                    isReviewedByCompanySupervisor) &&
            (identical(other.companySupervisorComment, companySupervisorComment) ||
                other.companySupervisorComment == companySupervisorComment) &&
            (identical(other.companySupervisorRating, companySupervisorRating) ||
                other.companySupervisorRating == companySupervisorRating) &&
            (identical(other.companyReviewedAt, companyReviewedAt) ||
                other.companyReviewedAt == companyReviewedAt) &&
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
            (identical(other.status, status) || other.status == status) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
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
        weeklyOverview,
        totalHoursWorked,
        keyAccomplishments,
        challengesSummary,
        skillsAcquired,
        lessonsLearned,
        const DeepCollectionEquality().hash(_dailyEntryIds),
        isReviewedByCompanySupervisor,
        companySupervisorComment,
        companySupervisorRating,
        companyReviewedAt,
        isReviewedByUniversitySupervisor,
        universitySupervisorComment,
        universitySupervisorRating,
        universityReviewedAt,
        status,
        submittedAt,
        createdAt,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyLogbookSummaryModelImplCopyWith<_$WeeklyLogbookSummaryModelImpl>
      get copyWith => __$$WeeklyLogbookSummaryModelImplCopyWithImpl<
          _$WeeklyLogbookSummaryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyLogbookSummaryModelImplToJson(
      this,
    );
  }
}

abstract class _WeeklyLogbookSummaryModel implements WeeklyLogbookSummaryModel {
  const factory _WeeklyLogbookSummaryModel(
      {final String? id,
      required final String studentId,
      required final String placementId,
      required final int weekNumber,
      required final DateTime weekStartDate,
      required final DateTime weekEndDate,
      required final String weeklyOverview,
      required final double totalHoursWorked,
      final String? keyAccomplishments,
      final String? challengesSummary,
      final String? skillsAcquired,
      final String? lessonsLearned,
      final List<String> dailyEntryIds,
      final bool isReviewedByCompanySupervisor,
      final String? companySupervisorComment,
      final double? companySupervisorRating,
      final DateTime? companyReviewedAt,
      final bool isReviewedByUniversitySupervisor,
      final String? universitySupervisorComment,
      final double? universitySupervisorRating,
      final DateTime? universityReviewedAt,
      final String status,
      final DateTime? submittedAt,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$WeeklyLogbookSummaryModelImpl;

  factory _WeeklyLogbookSummaryModel.fromJson(Map<String, dynamic> json) =
      _$WeeklyLogbookSummaryModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get studentId;
  @override
  String get placementId;
  @override
  int get weekNumber;
  @override
  DateTime get weekStartDate;
  @override
  DateTime get weekEndDate;
  @override // Weekly Overview (compiled by student)
  String get weeklyOverview;
  @override
  double get totalHoursWorked;
  @override
  String? get keyAccomplishments;
  @override
  String? get challengesSummary;
  @override
  String? get skillsAcquired;
  @override
  String? get lessonsLearned;
  @override // References to daily entries
  List<String> get dailyEntryIds;
  @override // Company Supervisor Review
  bool get isReviewedByCompanySupervisor;
  @override
  String? get companySupervisorComment;
  @override
  double? get companySupervisorRating;
  @override
  DateTime? get companyReviewedAt;
  @override // University Supervisor Review
  bool get isReviewedByUniversitySupervisor;
  @override
  String? get universitySupervisorComment;
  @override
  double? get universitySupervisorRating;
  @override
  DateTime? get universityReviewedAt;
  @override // Status
  String get status;
  @override // draft, submitted, reviewed
  DateTime? get submittedAt;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$WeeklyLogbookSummaryModelImplCopyWith<_$WeeklyLogbookSummaryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
