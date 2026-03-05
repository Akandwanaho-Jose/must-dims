// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'evaluation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EvaluationModel _$EvaluationModelFromJson(Map<String, dynamic> json) {
  return _EvaluationModel.fromJson(json);
}

/// @nodoc
mixin _$EvaluationModel {
  String? get id => throw _privateConstructorUsedError;
  String get placementId => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  EvaluationType get evaluatorType => throw _privateConstructorUsedError;
  String get evaluatorId => throw _privateConstructorUsedError;
  String? get evaluatorName =>
      throw _privateConstructorUsedError; // Overall marks
  double get finalMarks => throw _privateConstructorUsedError; // Out of 100
// Category ratings (1-5 stars each)
  double get technicalSkillsRating => throw _privateConstructorUsedError;
  double get workEthicRating => throw _privateConstructorUsedError;
  double get communicationRating => throw _privateConstructorUsedError;
  double get problemSolvingRating => throw _privateConstructorUsedError;
  double get initiativeRating => throw _privateConstructorUsedError;
  double get teamworkRating =>
      throw _privateConstructorUsedError; // Attendance (for company supervisor)
  int? get daysPresent => throw _privateConstructorUsedError;
  int? get daysAbsent => throw _privateConstructorUsedError;
  int? get totalWorkingDays =>
      throw _privateConstructorUsedError; // Recommendations
  String? get overallComments => throw _privateConstructorUsedError;
  String? get strengthsHighlighted => throw _privateConstructorUsedError;
  String? get areasForImprovement => throw _privateConstructorUsedError;
  String? get recommendationsForFutureInterns =>
      throw _privateConstructorUsedError; // Hiring potential (for company supervisor)
  bool? get wouldHireAgain => throw _privateConstructorUsedError;
  String? get hiringConditions =>
      throw _privateConstructorUsedError; // Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get submittedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EvaluationModelCopyWith<EvaluationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EvaluationModelCopyWith<$Res> {
  factory $EvaluationModelCopyWith(
          EvaluationModel value, $Res Function(EvaluationModel) then) =
      _$EvaluationModelCopyWithImpl<$Res, EvaluationModel>;
  @useResult
  $Res call(
      {String? id,
      String placementId,
      String studentId,
      EvaluationType evaluatorType,
      String evaluatorId,
      String? evaluatorName,
      double finalMarks,
      double technicalSkillsRating,
      double workEthicRating,
      double communicationRating,
      double problemSolvingRating,
      double initiativeRating,
      double teamworkRating,
      int? daysPresent,
      int? daysAbsent,
      int? totalWorkingDays,
      String? overallComments,
      String? strengthsHighlighted,
      String? areasForImprovement,
      String? recommendationsForFutureInterns,
      bool? wouldHireAgain,
      String? hiringConditions,
      DateTime? createdAt,
      DateTime? submittedAt});
}

/// @nodoc
class _$EvaluationModelCopyWithImpl<$Res, $Val extends EvaluationModel>
    implements $EvaluationModelCopyWith<$Res> {
  _$EvaluationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? placementId = null,
    Object? studentId = null,
    Object? evaluatorType = null,
    Object? evaluatorId = null,
    Object? evaluatorName = freezed,
    Object? finalMarks = null,
    Object? technicalSkillsRating = null,
    Object? workEthicRating = null,
    Object? communicationRating = null,
    Object? problemSolvingRating = null,
    Object? initiativeRating = null,
    Object? teamworkRating = null,
    Object? daysPresent = freezed,
    Object? daysAbsent = freezed,
    Object? totalWorkingDays = freezed,
    Object? overallComments = freezed,
    Object? strengthsHighlighted = freezed,
    Object? areasForImprovement = freezed,
    Object? recommendationsForFutureInterns = freezed,
    Object? wouldHireAgain = freezed,
    Object? hiringConditions = freezed,
    Object? createdAt = freezed,
    Object? submittedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      placementId: null == placementId
          ? _value.placementId
          : placementId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      evaluatorType: null == evaluatorType
          ? _value.evaluatorType
          : evaluatorType // ignore: cast_nullable_to_non_nullable
              as EvaluationType,
      evaluatorId: null == evaluatorId
          ? _value.evaluatorId
          : evaluatorId // ignore: cast_nullable_to_non_nullable
              as String,
      evaluatorName: freezed == evaluatorName
          ? _value.evaluatorName
          : evaluatorName // ignore: cast_nullable_to_non_nullable
              as String?,
      finalMarks: null == finalMarks
          ? _value.finalMarks
          : finalMarks // ignore: cast_nullable_to_non_nullable
              as double,
      technicalSkillsRating: null == technicalSkillsRating
          ? _value.technicalSkillsRating
          : technicalSkillsRating // ignore: cast_nullable_to_non_nullable
              as double,
      workEthicRating: null == workEthicRating
          ? _value.workEthicRating
          : workEthicRating // ignore: cast_nullable_to_non_nullable
              as double,
      communicationRating: null == communicationRating
          ? _value.communicationRating
          : communicationRating // ignore: cast_nullable_to_non_nullable
              as double,
      problemSolvingRating: null == problemSolvingRating
          ? _value.problemSolvingRating
          : problemSolvingRating // ignore: cast_nullable_to_non_nullable
              as double,
      initiativeRating: null == initiativeRating
          ? _value.initiativeRating
          : initiativeRating // ignore: cast_nullable_to_non_nullable
              as double,
      teamworkRating: null == teamworkRating
          ? _value.teamworkRating
          : teamworkRating // ignore: cast_nullable_to_non_nullable
              as double,
      daysPresent: freezed == daysPresent
          ? _value.daysPresent
          : daysPresent // ignore: cast_nullable_to_non_nullable
              as int?,
      daysAbsent: freezed == daysAbsent
          ? _value.daysAbsent
          : daysAbsent // ignore: cast_nullable_to_non_nullable
              as int?,
      totalWorkingDays: freezed == totalWorkingDays
          ? _value.totalWorkingDays
          : totalWorkingDays // ignore: cast_nullable_to_non_nullable
              as int?,
      overallComments: freezed == overallComments
          ? _value.overallComments
          : overallComments // ignore: cast_nullable_to_non_nullable
              as String?,
      strengthsHighlighted: freezed == strengthsHighlighted
          ? _value.strengthsHighlighted
          : strengthsHighlighted // ignore: cast_nullable_to_non_nullable
              as String?,
      areasForImprovement: freezed == areasForImprovement
          ? _value.areasForImprovement
          : areasForImprovement // ignore: cast_nullable_to_non_nullable
              as String?,
      recommendationsForFutureInterns: freezed ==
              recommendationsForFutureInterns
          ? _value.recommendationsForFutureInterns
          : recommendationsForFutureInterns // ignore: cast_nullable_to_non_nullable
              as String?,
      wouldHireAgain: freezed == wouldHireAgain
          ? _value.wouldHireAgain
          : wouldHireAgain // ignore: cast_nullable_to_non_nullable
              as bool?,
      hiringConditions: freezed == hiringConditions
          ? _value.hiringConditions
          : hiringConditions // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EvaluationModelImplCopyWith<$Res>
    implements $EvaluationModelCopyWith<$Res> {
  factory _$$EvaluationModelImplCopyWith(_$EvaluationModelImpl value,
          $Res Function(_$EvaluationModelImpl) then) =
      __$$EvaluationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String placementId,
      String studentId,
      EvaluationType evaluatorType,
      String evaluatorId,
      String? evaluatorName,
      double finalMarks,
      double technicalSkillsRating,
      double workEthicRating,
      double communicationRating,
      double problemSolvingRating,
      double initiativeRating,
      double teamworkRating,
      int? daysPresent,
      int? daysAbsent,
      int? totalWorkingDays,
      String? overallComments,
      String? strengthsHighlighted,
      String? areasForImprovement,
      String? recommendationsForFutureInterns,
      bool? wouldHireAgain,
      String? hiringConditions,
      DateTime? createdAt,
      DateTime? submittedAt});
}

/// @nodoc
class __$$EvaluationModelImplCopyWithImpl<$Res>
    extends _$EvaluationModelCopyWithImpl<$Res, _$EvaluationModelImpl>
    implements _$$EvaluationModelImplCopyWith<$Res> {
  __$$EvaluationModelImplCopyWithImpl(
      _$EvaluationModelImpl _value, $Res Function(_$EvaluationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? placementId = null,
    Object? studentId = null,
    Object? evaluatorType = null,
    Object? evaluatorId = null,
    Object? evaluatorName = freezed,
    Object? finalMarks = null,
    Object? technicalSkillsRating = null,
    Object? workEthicRating = null,
    Object? communicationRating = null,
    Object? problemSolvingRating = null,
    Object? initiativeRating = null,
    Object? teamworkRating = null,
    Object? daysPresent = freezed,
    Object? daysAbsent = freezed,
    Object? totalWorkingDays = freezed,
    Object? overallComments = freezed,
    Object? strengthsHighlighted = freezed,
    Object? areasForImprovement = freezed,
    Object? recommendationsForFutureInterns = freezed,
    Object? wouldHireAgain = freezed,
    Object? hiringConditions = freezed,
    Object? createdAt = freezed,
    Object? submittedAt = freezed,
  }) {
    return _then(_$EvaluationModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      placementId: null == placementId
          ? _value.placementId
          : placementId // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      evaluatorType: null == evaluatorType
          ? _value.evaluatorType
          : evaluatorType // ignore: cast_nullable_to_non_nullable
              as EvaluationType,
      evaluatorId: null == evaluatorId
          ? _value.evaluatorId
          : evaluatorId // ignore: cast_nullable_to_non_nullable
              as String,
      evaluatorName: freezed == evaluatorName
          ? _value.evaluatorName
          : evaluatorName // ignore: cast_nullable_to_non_nullable
              as String?,
      finalMarks: null == finalMarks
          ? _value.finalMarks
          : finalMarks // ignore: cast_nullable_to_non_nullable
              as double,
      technicalSkillsRating: null == technicalSkillsRating
          ? _value.technicalSkillsRating
          : technicalSkillsRating // ignore: cast_nullable_to_non_nullable
              as double,
      workEthicRating: null == workEthicRating
          ? _value.workEthicRating
          : workEthicRating // ignore: cast_nullable_to_non_nullable
              as double,
      communicationRating: null == communicationRating
          ? _value.communicationRating
          : communicationRating // ignore: cast_nullable_to_non_nullable
              as double,
      problemSolvingRating: null == problemSolvingRating
          ? _value.problemSolvingRating
          : problemSolvingRating // ignore: cast_nullable_to_non_nullable
              as double,
      initiativeRating: null == initiativeRating
          ? _value.initiativeRating
          : initiativeRating // ignore: cast_nullable_to_non_nullable
              as double,
      teamworkRating: null == teamworkRating
          ? _value.teamworkRating
          : teamworkRating // ignore: cast_nullable_to_non_nullable
              as double,
      daysPresent: freezed == daysPresent
          ? _value.daysPresent
          : daysPresent // ignore: cast_nullable_to_non_nullable
              as int?,
      daysAbsent: freezed == daysAbsent
          ? _value.daysAbsent
          : daysAbsent // ignore: cast_nullable_to_non_nullable
              as int?,
      totalWorkingDays: freezed == totalWorkingDays
          ? _value.totalWorkingDays
          : totalWorkingDays // ignore: cast_nullable_to_non_nullable
              as int?,
      overallComments: freezed == overallComments
          ? _value.overallComments
          : overallComments // ignore: cast_nullable_to_non_nullable
              as String?,
      strengthsHighlighted: freezed == strengthsHighlighted
          ? _value.strengthsHighlighted
          : strengthsHighlighted // ignore: cast_nullable_to_non_nullable
              as String?,
      areasForImprovement: freezed == areasForImprovement
          ? _value.areasForImprovement
          : areasForImprovement // ignore: cast_nullable_to_non_nullable
              as String?,
      recommendationsForFutureInterns: freezed ==
              recommendationsForFutureInterns
          ? _value.recommendationsForFutureInterns
          : recommendationsForFutureInterns // ignore: cast_nullable_to_non_nullable
              as String?,
      wouldHireAgain: freezed == wouldHireAgain
          ? _value.wouldHireAgain
          : wouldHireAgain // ignore: cast_nullable_to_non_nullable
              as bool?,
      hiringConditions: freezed == hiringConditions
          ? _value.hiringConditions
          : hiringConditions // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      submittedAt: freezed == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EvaluationModelImpl implements _EvaluationModel {
  const _$EvaluationModelImpl(
      {this.id,
      required this.placementId,
      required this.studentId,
      required this.evaluatorType,
      required this.evaluatorId,
      this.evaluatorName,
      required this.finalMarks,
      required this.technicalSkillsRating,
      required this.workEthicRating,
      required this.communicationRating,
      required this.problemSolvingRating,
      required this.initiativeRating,
      required this.teamworkRating,
      this.daysPresent,
      this.daysAbsent,
      this.totalWorkingDays,
      this.overallComments,
      this.strengthsHighlighted,
      this.areasForImprovement,
      this.recommendationsForFutureInterns,
      this.wouldHireAgain,
      this.hiringConditions,
      this.createdAt,
      this.submittedAt});

  factory _$EvaluationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EvaluationModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String placementId;
  @override
  final String studentId;
  @override
  final EvaluationType evaluatorType;
  @override
  final String evaluatorId;
  @override
  final String? evaluatorName;
// Overall marks
  @override
  final double finalMarks;
// Out of 100
// Category ratings (1-5 stars each)
  @override
  final double technicalSkillsRating;
  @override
  final double workEthicRating;
  @override
  final double communicationRating;
  @override
  final double problemSolvingRating;
  @override
  final double initiativeRating;
  @override
  final double teamworkRating;
// Attendance (for company supervisor)
  @override
  final int? daysPresent;
  @override
  final int? daysAbsent;
  @override
  final int? totalWorkingDays;
// Recommendations
  @override
  final String? overallComments;
  @override
  final String? strengthsHighlighted;
  @override
  final String? areasForImprovement;
  @override
  final String? recommendationsForFutureInterns;
// Hiring potential (for company supervisor)
  @override
  final bool? wouldHireAgain;
  @override
  final String? hiringConditions;
// Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? submittedAt;

  @override
  String toString() {
    return 'EvaluationModel(id: $id, placementId: $placementId, studentId: $studentId, evaluatorType: $evaluatorType, evaluatorId: $evaluatorId, evaluatorName: $evaluatorName, finalMarks: $finalMarks, technicalSkillsRating: $technicalSkillsRating, workEthicRating: $workEthicRating, communicationRating: $communicationRating, problemSolvingRating: $problemSolvingRating, initiativeRating: $initiativeRating, teamworkRating: $teamworkRating, daysPresent: $daysPresent, daysAbsent: $daysAbsent, totalWorkingDays: $totalWorkingDays, overallComments: $overallComments, strengthsHighlighted: $strengthsHighlighted, areasForImprovement: $areasForImprovement, recommendationsForFutureInterns: $recommendationsForFutureInterns, wouldHireAgain: $wouldHireAgain, hiringConditions: $hiringConditions, createdAt: $createdAt, submittedAt: $submittedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EvaluationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.placementId, placementId) ||
                other.placementId == placementId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.evaluatorType, evaluatorType) ||
                other.evaluatorType == evaluatorType) &&
            (identical(other.evaluatorId, evaluatorId) ||
                other.evaluatorId == evaluatorId) &&
            (identical(other.evaluatorName, evaluatorName) ||
                other.evaluatorName == evaluatorName) &&
            (identical(other.finalMarks, finalMarks) ||
                other.finalMarks == finalMarks) &&
            (identical(other.technicalSkillsRating, technicalSkillsRating) ||
                other.technicalSkillsRating == technicalSkillsRating) &&
            (identical(other.workEthicRating, workEthicRating) ||
                other.workEthicRating == workEthicRating) &&
            (identical(other.communicationRating, communicationRating) ||
                other.communicationRating == communicationRating) &&
            (identical(other.problemSolvingRating, problemSolvingRating) ||
                other.problemSolvingRating == problemSolvingRating) &&
            (identical(other.initiativeRating, initiativeRating) ||
                other.initiativeRating == initiativeRating) &&
            (identical(other.teamworkRating, teamworkRating) ||
                other.teamworkRating == teamworkRating) &&
            (identical(other.daysPresent, daysPresent) ||
                other.daysPresent == daysPresent) &&
            (identical(other.daysAbsent, daysAbsent) ||
                other.daysAbsent == daysAbsent) &&
            (identical(other.totalWorkingDays, totalWorkingDays) ||
                other.totalWorkingDays == totalWorkingDays) &&
            (identical(other.overallComments, overallComments) ||
                other.overallComments == overallComments) &&
            (identical(other.strengthsHighlighted, strengthsHighlighted) ||
                other.strengthsHighlighted == strengthsHighlighted) &&
            (identical(other.areasForImprovement, areasForImprovement) ||
                other.areasForImprovement == areasForImprovement) &&
            (identical(other.recommendationsForFutureInterns,
                    recommendationsForFutureInterns) ||
                other.recommendationsForFutureInterns ==
                    recommendationsForFutureInterns) &&
            (identical(other.wouldHireAgain, wouldHireAgain) ||
                other.wouldHireAgain == wouldHireAgain) &&
            (identical(other.hiringConditions, hiringConditions) ||
                other.hiringConditions == hiringConditions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        placementId,
        studentId,
        evaluatorType,
        evaluatorId,
        evaluatorName,
        finalMarks,
        technicalSkillsRating,
        workEthicRating,
        communicationRating,
        problemSolvingRating,
        initiativeRating,
        teamworkRating,
        daysPresent,
        daysAbsent,
        totalWorkingDays,
        overallComments,
        strengthsHighlighted,
        areasForImprovement,
        recommendationsForFutureInterns,
        wouldHireAgain,
        hiringConditions,
        createdAt,
        submittedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EvaluationModelImplCopyWith<_$EvaluationModelImpl> get copyWith =>
      __$$EvaluationModelImplCopyWithImpl<_$EvaluationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EvaluationModelImplToJson(
      this,
    );
  }
}

abstract class _EvaluationModel implements EvaluationModel {
  const factory _EvaluationModel(
      {final String? id,
      required final String placementId,
      required final String studentId,
      required final EvaluationType evaluatorType,
      required final String evaluatorId,
      final String? evaluatorName,
      required final double finalMarks,
      required final double technicalSkillsRating,
      required final double workEthicRating,
      required final double communicationRating,
      required final double problemSolvingRating,
      required final double initiativeRating,
      required final double teamworkRating,
      final int? daysPresent,
      final int? daysAbsent,
      final int? totalWorkingDays,
      final String? overallComments,
      final String? strengthsHighlighted,
      final String? areasForImprovement,
      final String? recommendationsForFutureInterns,
      final bool? wouldHireAgain,
      final String? hiringConditions,
      final DateTime? createdAt,
      final DateTime? submittedAt}) = _$EvaluationModelImpl;

  factory _EvaluationModel.fromJson(Map<String, dynamic> json) =
      _$EvaluationModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get placementId;
  @override
  String get studentId;
  @override
  EvaluationType get evaluatorType;
  @override
  String get evaluatorId;
  @override
  String? get evaluatorName;
  @override // Overall marks
  double get finalMarks;
  @override // Out of 100
// Category ratings (1-5 stars each)
  double get technicalSkillsRating;
  @override
  double get workEthicRating;
  @override
  double get communicationRating;
  @override
  double get problemSolvingRating;
  @override
  double get initiativeRating;
  @override
  double get teamworkRating;
  @override // Attendance (for company supervisor)
  int? get daysPresent;
  @override
  int? get daysAbsent;
  @override
  int? get totalWorkingDays;
  @override // Recommendations
  String? get overallComments;
  @override
  String? get strengthsHighlighted;
  @override
  String? get areasForImprovement;
  @override
  String? get recommendationsForFutureInterns;
  @override // Hiring potential (for company supervisor)
  bool? get wouldHireAgain;
  @override
  String? get hiringConditions;
  @override // Timestamps
  DateTime? get createdAt;
  @override
  DateTime? get submittedAt;
  @override
  @JsonKey(ignore: true)
  _$$EvaluationModelImplCopyWith<_$EvaluationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
