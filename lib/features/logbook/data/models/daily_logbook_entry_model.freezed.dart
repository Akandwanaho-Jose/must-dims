// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_logbook_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyLogbookEntryModel _$DailyLogbookEntryModelFromJson(
    Map<String, dynamic> json) {
  return _DailyLogbookEntryModel.fromJson(json);
}

/// @nodoc
mixin _$DailyLogbookEntryModel {
  String? get id => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get placementId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get dayNumber => throw _privateConstructorUsedError;
  String get tasksPerformed => throw _privateConstructorUsedError;
  double get hoursWorked => throw _privateConstructorUsedError;
  String? get challenges => throw _privateConstructorUsedError;
  String? get skillsLearned => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  List<String> get attachmentUrls => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DailyLogbookEntryModelCopyWith<DailyLogbookEntryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyLogbookEntryModelCopyWith<$Res> {
  factory $DailyLogbookEntryModelCopyWith(DailyLogbookEntryModel value,
          $Res Function(DailyLogbookEntryModel) then) =
      _$DailyLogbookEntryModelCopyWithImpl<$Res, DailyLogbookEntryModel>;
  @useResult
  $Res call(
      {String? id,
      String studentId,
      String placementId,
      DateTime date,
      int dayNumber,
      String tasksPerformed,
      double hoursWorked,
      String? challenges,
      String? skillsLearned,
      String? notes,
      List<String> attachmentUrls,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$DailyLogbookEntryModelCopyWithImpl<$Res,
        $Val extends DailyLogbookEntryModel>
    implements $DailyLogbookEntryModelCopyWith<$Res> {
  _$DailyLogbookEntryModelCopyWithImpl(this._value, this._then);

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
    Object? date = null,
    Object? dayNumber = null,
    Object? tasksPerformed = null,
    Object? hoursWorked = null,
    Object? challenges = freezed,
    Object? skillsLearned = freezed,
    Object? notes = freezed,
    Object? attachmentUrls = null,
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dayNumber: null == dayNumber
          ? _value.dayNumber
          : dayNumber // ignore: cast_nullable_to_non_nullable
              as int,
      tasksPerformed: null == tasksPerformed
          ? _value.tasksPerformed
          : tasksPerformed // ignore: cast_nullable_to_non_nullable
              as String,
      hoursWorked: null == hoursWorked
          ? _value.hoursWorked
          : hoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      challenges: freezed == challenges
          ? _value.challenges
          : challenges // ignore: cast_nullable_to_non_nullable
              as String?,
      skillsLearned: freezed == skillsLearned
          ? _value.skillsLearned
          : skillsLearned // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      attachmentUrls: null == attachmentUrls
          ? _value.attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
abstract class _$$DailyLogbookEntryModelImplCopyWith<$Res>
    implements $DailyLogbookEntryModelCopyWith<$Res> {
  factory _$$DailyLogbookEntryModelImplCopyWith(
          _$DailyLogbookEntryModelImpl value,
          $Res Function(_$DailyLogbookEntryModelImpl) then) =
      __$$DailyLogbookEntryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String studentId,
      String placementId,
      DateTime date,
      int dayNumber,
      String tasksPerformed,
      double hoursWorked,
      String? challenges,
      String? skillsLearned,
      String? notes,
      List<String> attachmentUrls,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$DailyLogbookEntryModelImplCopyWithImpl<$Res>
    extends _$DailyLogbookEntryModelCopyWithImpl<$Res,
        _$DailyLogbookEntryModelImpl>
    implements _$$DailyLogbookEntryModelImplCopyWith<$Res> {
  __$$DailyLogbookEntryModelImplCopyWithImpl(
      _$DailyLogbookEntryModelImpl _value,
      $Res Function(_$DailyLogbookEntryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? studentId = null,
    Object? placementId = null,
    Object? date = null,
    Object? dayNumber = null,
    Object? tasksPerformed = null,
    Object? hoursWorked = null,
    Object? challenges = freezed,
    Object? skillsLearned = freezed,
    Object? notes = freezed,
    Object? attachmentUrls = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DailyLogbookEntryModelImpl(
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      dayNumber: null == dayNumber
          ? _value.dayNumber
          : dayNumber // ignore: cast_nullable_to_non_nullable
              as int,
      tasksPerformed: null == tasksPerformed
          ? _value.tasksPerformed
          : tasksPerformed // ignore: cast_nullable_to_non_nullable
              as String,
      hoursWorked: null == hoursWorked
          ? _value.hoursWorked
          : hoursWorked // ignore: cast_nullable_to_non_nullable
              as double,
      challenges: freezed == challenges
          ? _value.challenges
          : challenges // ignore: cast_nullable_to_non_nullable
              as String?,
      skillsLearned: freezed == skillsLearned
          ? _value.skillsLearned
          : skillsLearned // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      attachmentUrls: null == attachmentUrls
          ? _value._attachmentUrls
          : attachmentUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
class _$DailyLogbookEntryModelImpl implements _DailyLogbookEntryModel {
  const _$DailyLogbookEntryModelImpl(
      {this.id,
      required this.studentId,
      required this.placementId,
      required this.date,
      required this.dayNumber,
      required this.tasksPerformed,
      required this.hoursWorked,
      this.challenges,
      this.skillsLearned,
      this.notes,
      final List<String> attachmentUrls = const [],
      this.createdAt,
      this.updatedAt})
      : _attachmentUrls = attachmentUrls;

  factory _$DailyLogbookEntryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyLogbookEntryModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String studentId;
  @override
  final String placementId;
  @override
  final DateTime date;
  @override
  final int dayNumber;
  @override
  final String tasksPerformed;
  @override
  final double hoursWorked;
  @override
  final String? challenges;
  @override
  final String? skillsLearned;
  @override
  final String? notes;
  final List<String> _attachmentUrls;
  @override
  @JsonKey()
  List<String> get attachmentUrls {
    if (_attachmentUrls is EqualUnmodifiableListView) return _attachmentUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachmentUrls);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'DailyLogbookEntryModel(id: $id, studentId: $studentId, placementId: $placementId, date: $date, dayNumber: $dayNumber, tasksPerformed: $tasksPerformed, hoursWorked: $hoursWorked, challenges: $challenges, skillsLearned: $skillsLearned, notes: $notes, attachmentUrls: $attachmentUrls, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyLogbookEntryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.placementId, placementId) ||
                other.placementId == placementId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.dayNumber, dayNumber) ||
                other.dayNumber == dayNumber) &&
            (identical(other.tasksPerformed, tasksPerformed) ||
                other.tasksPerformed == tasksPerformed) &&
            (identical(other.hoursWorked, hoursWorked) ||
                other.hoursWorked == hoursWorked) &&
            (identical(other.challenges, challenges) ||
                other.challenges == challenges) &&
            (identical(other.skillsLearned, skillsLearned) ||
                other.skillsLearned == skillsLearned) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._attachmentUrls, _attachmentUrls) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      studentId,
      placementId,
      date,
      dayNumber,
      tasksPerformed,
      hoursWorked,
      challenges,
      skillsLearned,
      notes,
      const DeepCollectionEquality().hash(_attachmentUrls),
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyLogbookEntryModelImplCopyWith<_$DailyLogbookEntryModelImpl>
      get copyWith => __$$DailyLogbookEntryModelImplCopyWithImpl<
          _$DailyLogbookEntryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyLogbookEntryModelImplToJson(
      this,
    );
  }
}

abstract class _DailyLogbookEntryModel implements DailyLogbookEntryModel {
  const factory _DailyLogbookEntryModel(
      {final String? id,
      required final String studentId,
      required final String placementId,
      required final DateTime date,
      required final int dayNumber,
      required final String tasksPerformed,
      required final double hoursWorked,
      final String? challenges,
      final String? skillsLearned,
      final String? notes,
      final List<String> attachmentUrls,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$DailyLogbookEntryModelImpl;

  factory _DailyLogbookEntryModel.fromJson(Map<String, dynamic> json) =
      _$DailyLogbookEntryModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get studentId;
  @override
  String get placementId;
  @override
  DateTime get date;
  @override
  int get dayNumber;
  @override
  String get tasksPerformed;
  @override
  double get hoursWorked;
  @override
  String? get challenges;
  @override
  String? get skillsLearned;
  @override
  String? get notes;
  @override
  List<String> get attachmentUrls;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$DailyLogbookEntryModelImplCopyWith<_$DailyLogbookEntryModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
