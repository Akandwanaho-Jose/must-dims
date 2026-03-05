// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_supervisor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompanySupervisorModel _$CompanySupervisorModelFromJson(
    Map<String, dynamic> json) {
  return _CompanySupervisorModel.fromJson(json);
}

/// @nodoc
mixin _$CompanySupervisorModel {
  String get uid => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get companyId => throw _privateConstructorUsedError;
  String? get companyName =>
      throw _privateConstructorUsedError; // Denormalized for quick access
  String? get position => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError; // Access control
  bool get isActive => throw _privateConstructorUsedError;
  bool get emailVerified =>
      throw _privateConstructorUsedError; // Student management
  List<String> get assignedStudentIds => throw _privateConstructorUsedError;
  int get currentLoad => throw _privateConstructorUsedError; // Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanySupervisorModelCopyWith<CompanySupervisorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanySupervisorModelCopyWith<$Res> {
  factory $CompanySupervisorModelCopyWith(CompanySupervisorModel value,
          $Res Function(CompanySupervisorModel) then) =
      _$CompanySupervisorModelCopyWithImpl<$Res, CompanySupervisorModel>;
  @useResult
  $Res call(
      {String uid,
      String fullName,
      String email,
      String companyId,
      String? companyName,
      String? position,
      String? phoneNumber,
      String? photoUrl,
      bool isActive,
      bool emailVerified,
      List<String> assignedStudentIds,
      int currentLoad,
      DateTime? createdAt,
      DateTime? lastLoginAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$CompanySupervisorModelCopyWithImpl<$Res,
        $Val extends CompanySupervisorModel>
    implements $CompanySupervisorModelCopyWith<$Res> {
  _$CompanySupervisorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? fullName = null,
    Object? email = null,
    Object? companyId = null,
    Object? companyName = freezed,
    Object? position = freezed,
    Object? phoneNumber = freezed,
    Object? photoUrl = freezed,
    Object? isActive = null,
    Object? emailVerified = null,
    Object? assignedStudentIds = null,
    Object? currentLoad = null,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      assignedStudentIds: null == assignedStudentIds
          ? _value.assignedStudentIds
          : assignedStudentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentLoad: null == currentLoad
          ? _value.currentLoad
          : currentLoad // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompanySupervisorModelImplCopyWith<$Res>
    implements $CompanySupervisorModelCopyWith<$Res> {
  factory _$$CompanySupervisorModelImplCopyWith(
          _$CompanySupervisorModelImpl value,
          $Res Function(_$CompanySupervisorModelImpl) then) =
      __$$CompanySupervisorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String fullName,
      String email,
      String companyId,
      String? companyName,
      String? position,
      String? phoneNumber,
      String? photoUrl,
      bool isActive,
      bool emailVerified,
      List<String> assignedStudentIds,
      int currentLoad,
      DateTime? createdAt,
      DateTime? lastLoginAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$CompanySupervisorModelImplCopyWithImpl<$Res>
    extends _$CompanySupervisorModelCopyWithImpl<$Res,
        _$CompanySupervisorModelImpl>
    implements _$$CompanySupervisorModelImplCopyWith<$Res> {
  __$$CompanySupervisorModelImplCopyWithImpl(
      _$CompanySupervisorModelImpl _value,
      $Res Function(_$CompanySupervisorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? fullName = null,
    Object? email = null,
    Object? companyId = null,
    Object? companyName = freezed,
    Object? position = freezed,
    Object? phoneNumber = freezed,
    Object? photoUrl = freezed,
    Object? isActive = null,
    Object? emailVerified = null,
    Object? assignedStudentIds = null,
    Object? currentLoad = null,
    Object? createdAt = freezed,
    Object? lastLoginAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$CompanySupervisorModelImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      companyId: null == companyId
          ? _value.companyId
          : companyId // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: freezed == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      assignedStudentIds: null == assignedStudentIds
          ? _value._assignedStudentIds
          : assignedStudentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentLoad: null == currentLoad
          ? _value.currentLoad
          : currentLoad // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
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
class _$CompanySupervisorModelImpl implements _CompanySupervisorModel {
  const _$CompanySupervisorModelImpl(
      {required this.uid,
      required this.fullName,
      required this.email,
      required this.companyId,
      this.companyName,
      this.position,
      this.phoneNumber,
      this.photoUrl,
      this.isActive = true,
      this.emailVerified = false,
      final List<String> assignedStudentIds = const [],
      this.currentLoad = 0,
      this.createdAt,
      this.lastLoginAt,
      this.updatedAt})
      : _assignedStudentIds = assignedStudentIds;

  factory _$CompanySupervisorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanySupervisorModelImplFromJson(json);

  @override
  final String uid;
  @override
  final String fullName;
  @override
  final String email;
  @override
  final String companyId;
  @override
  final String? companyName;
// Denormalized for quick access
  @override
  final String? position;
  @override
  final String? phoneNumber;
  @override
  final String? photoUrl;
// Access control
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool emailVerified;
// Student management
  final List<String> _assignedStudentIds;
// Student management
  @override
  @JsonKey()
  List<String> get assignedStudentIds {
    if (_assignedStudentIds is EqualUnmodifiableListView)
      return _assignedStudentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignedStudentIds);
  }

  @override
  @JsonKey()
  final int currentLoad;
// Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastLoginAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'CompanySupervisorModel(uid: $uid, fullName: $fullName, email: $email, companyId: $companyId, companyName: $companyName, position: $position, phoneNumber: $phoneNumber, photoUrl: $photoUrl, isActive: $isActive, emailVerified: $emailVerified, assignedStudentIds: $assignedStudentIds, currentLoad: $currentLoad, createdAt: $createdAt, lastLoginAt: $lastLoginAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanySupervisorModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.companyId, companyId) ||
                other.companyId == companyId) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            const DeepCollectionEquality()
                .equals(other._assignedStudentIds, _assignedStudentIds) &&
            (identical(other.currentLoad, currentLoad) ||
                other.currentLoad == currentLoad) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      fullName,
      email,
      companyId,
      companyName,
      position,
      phoneNumber,
      photoUrl,
      isActive,
      emailVerified,
      const DeepCollectionEquality().hash(_assignedStudentIds),
      currentLoad,
      createdAt,
      lastLoginAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanySupervisorModelImplCopyWith<_$CompanySupervisorModelImpl>
      get copyWith => __$$CompanySupervisorModelImplCopyWithImpl<
          _$CompanySupervisorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanySupervisorModelImplToJson(
      this,
    );
  }
}

abstract class _CompanySupervisorModel implements CompanySupervisorModel {
  const factory _CompanySupervisorModel(
      {required final String uid,
      required final String fullName,
      required final String email,
      required final String companyId,
      final String? companyName,
      final String? position,
      final String? phoneNumber,
      final String? photoUrl,
      final bool isActive,
      final bool emailVerified,
      final List<String> assignedStudentIds,
      final int currentLoad,
      final DateTime? createdAt,
      final DateTime? lastLoginAt,
      final DateTime? updatedAt}) = _$CompanySupervisorModelImpl;

  factory _CompanySupervisorModel.fromJson(Map<String, dynamic> json) =
      _$CompanySupervisorModelImpl.fromJson;

  @override
  String get uid;
  @override
  String get fullName;
  @override
  String get email;
  @override
  String get companyId;
  @override
  String? get companyName;
  @override // Denormalized for quick access
  String? get position;
  @override
  String? get phoneNumber;
  @override
  String? get photoUrl;
  @override // Access control
  bool get isActive;
  @override
  bool get emailVerified;
  @override // Student management
  List<String> get assignedStudentIds;
  @override
  int get currentLoad;
  @override // Timestamps
  DateTime? get createdAt;
  @override
  DateTime? get lastLoginAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$CompanySupervisorModelImplCopyWith<_$CompanySupervisorModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
