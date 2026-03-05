// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) {
  return _CompanyModel.fromJson(json);
}

/// @nodoc
mixin _$CompanyModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get industry => throw _privateConstructorUsedError;
  String get location =>
      throw _privateConstructorUsedError; // Contact information
  String? get contactEmail => throw _privateConstructorUsedError;
  String? get contactPhone => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError; // Visual
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get description =>
      throw _privateConstructorUsedError; // Intern capacity tracking - NEW
  int get maxInterns =>
      throw _privateConstructorUsedError; // How many interns they can take (0 = unlimited)
  int get currentInterns =>
      throw _privateConstructorUsedError; // Current number of active interns
// Preferred programs - NEW
  List<String> get preferredPrograms =>
      throw _privateConstructorUsedError; // e.g., ["Computer Science", "IT"]
// Company supervisor IDs - NEW
  List<String> get companySupervisorIds =>
      throw _privateConstructorUsedError; // UIDs of company supervisors
// Status
  bool get isActive => throw _privateConstructorUsedError;
  bool get acceptingInterns =>
      throw _privateConstructorUsedError; // NEW - Can toggle to stop accepting applications
// Additional info - NEW
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError; // Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyModelCopyWith<CompanyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyModelCopyWith<$Res> {
  factory $CompanyModelCopyWith(
          CompanyModel value, $Res Function(CompanyModel) then) =
      _$CompanyModelCopyWithImpl<$Res, CompanyModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String industry,
      String location,
      String? contactEmail,
      String? contactPhone,
      String? website,
      String? logoUrl,
      String? description,
      int maxInterns,
      int currentInterns,
      List<String> preferredPrograms,
      List<String> companySupervisorIds,
      bool isActive,
      bool acceptingInterns,
      String? address,
      String? city,
      String? country,
      String? postalCode,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$CompanyModelCopyWithImpl<$Res, $Val extends CompanyModel>
    implements $CompanyModelCopyWith<$Res> {
  _$CompanyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? industry = null,
    Object? location = null,
    Object? contactEmail = freezed,
    Object? contactPhone = freezed,
    Object? website = freezed,
    Object? logoUrl = freezed,
    Object? description = freezed,
    Object? maxInterns = null,
    Object? currentInterns = null,
    Object? preferredPrograms = null,
    Object? companySupervisorIds = null,
    Object? isActive = null,
    Object? acceptingInterns = null,
    Object? address = freezed,
    Object? city = freezed,
    Object? country = freezed,
    Object? postalCode = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      industry: null == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      contactEmail: freezed == contactEmail
          ? _value.contactEmail
          : contactEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPhone: freezed == contactPhone
          ? _value.contactPhone
          : contactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      maxInterns: null == maxInterns
          ? _value.maxInterns
          : maxInterns // ignore: cast_nullable_to_non_nullable
              as int,
      currentInterns: null == currentInterns
          ? _value.currentInterns
          : currentInterns // ignore: cast_nullable_to_non_nullable
              as int,
      preferredPrograms: null == preferredPrograms
          ? _value.preferredPrograms
          : preferredPrograms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      companySupervisorIds: null == companySupervisorIds
          ? _value.companySupervisorIds
          : companySupervisorIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      acceptingInterns: null == acceptingInterns
          ? _value.acceptingInterns
          : acceptingInterns // ignore: cast_nullable_to_non_nullable
              as bool,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$CompanyModelImplCopyWith<$Res>
    implements $CompanyModelCopyWith<$Res> {
  factory _$$CompanyModelImplCopyWith(
          _$CompanyModelImpl value, $Res Function(_$CompanyModelImpl) then) =
      __$$CompanyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String industry,
      String location,
      String? contactEmail,
      String? contactPhone,
      String? website,
      String? logoUrl,
      String? description,
      int maxInterns,
      int currentInterns,
      List<String> preferredPrograms,
      List<String> companySupervisorIds,
      bool isActive,
      bool acceptingInterns,
      String? address,
      String? city,
      String? country,
      String? postalCode,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$CompanyModelImplCopyWithImpl<$Res>
    extends _$CompanyModelCopyWithImpl<$Res, _$CompanyModelImpl>
    implements _$$CompanyModelImplCopyWith<$Res> {
  __$$CompanyModelImplCopyWithImpl(
      _$CompanyModelImpl _value, $Res Function(_$CompanyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? industry = null,
    Object? location = null,
    Object? contactEmail = freezed,
    Object? contactPhone = freezed,
    Object? website = freezed,
    Object? logoUrl = freezed,
    Object? description = freezed,
    Object? maxInterns = null,
    Object? currentInterns = null,
    Object? preferredPrograms = null,
    Object? companySupervisorIds = null,
    Object? isActive = null,
    Object? acceptingInterns = null,
    Object? address = freezed,
    Object? city = freezed,
    Object? country = freezed,
    Object? postalCode = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$CompanyModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      industry: null == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      contactEmail: freezed == contactEmail
          ? _value.contactEmail
          : contactEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      contactPhone: freezed == contactPhone
          ? _value.contactPhone
          : contactPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      maxInterns: null == maxInterns
          ? _value.maxInterns
          : maxInterns // ignore: cast_nullable_to_non_nullable
              as int,
      currentInterns: null == currentInterns
          ? _value.currentInterns
          : currentInterns // ignore: cast_nullable_to_non_nullable
              as int,
      preferredPrograms: null == preferredPrograms
          ? _value._preferredPrograms
          : preferredPrograms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      companySupervisorIds: null == companySupervisorIds
          ? _value._companySupervisorIds
          : companySupervisorIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      acceptingInterns: null == acceptingInterns
          ? _value.acceptingInterns
          : acceptingInterns // ignore: cast_nullable_to_non_nullable
              as bool,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$CompanyModelImpl implements _CompanyModel {
  const _$CompanyModelImpl(
      {required this.id,
      required this.name,
      required this.industry,
      required this.location,
      this.contactEmail,
      this.contactPhone,
      this.website,
      this.logoUrl,
      this.description,
      this.maxInterns = 0,
      this.currentInterns = 0,
      final List<String> preferredPrograms = const [],
      final List<String> companySupervisorIds = const [],
      this.isActive = true,
      this.acceptingInterns = true,
      this.address,
      this.city,
      this.country,
      this.postalCode,
      this.createdAt,
      this.updatedAt})
      : _preferredPrograms = preferredPrograms,
        _companySupervisorIds = companySupervisorIds;

  factory _$CompanyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String industry;
  @override
  final String location;
// Contact information
  @override
  final String? contactEmail;
  @override
  final String? contactPhone;
  @override
  final String? website;
// Visual
  @override
  final String? logoUrl;
  @override
  final String? description;
// Intern capacity tracking - NEW
  @override
  @JsonKey()
  final int maxInterns;
// How many interns they can take (0 = unlimited)
  @override
  @JsonKey()
  final int currentInterns;
// Current number of active interns
// Preferred programs - NEW
  final List<String> _preferredPrograms;
// Current number of active interns
// Preferred programs - NEW
  @override
  @JsonKey()
  List<String> get preferredPrograms {
    if (_preferredPrograms is EqualUnmodifiableListView)
      return _preferredPrograms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_preferredPrograms);
  }

// e.g., ["Computer Science", "IT"]
// Company supervisor IDs - NEW
  final List<String> _companySupervisorIds;
// e.g., ["Computer Science", "IT"]
// Company supervisor IDs - NEW
  @override
  @JsonKey()
  List<String> get companySupervisorIds {
    if (_companySupervisorIds is EqualUnmodifiableListView)
      return _companySupervisorIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_companySupervisorIds);
  }

// UIDs of company supervisors
// Status
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool acceptingInterns;
// NEW - Can toggle to stop accepting applications
// Additional info - NEW
  @override
  final String? address;
  @override
  final String? city;
  @override
  final String? country;
  @override
  final String? postalCode;
// Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'CompanyModel(id: $id, name: $name, industry: $industry, location: $location, contactEmail: $contactEmail, contactPhone: $contactPhone, website: $website, logoUrl: $logoUrl, description: $description, maxInterns: $maxInterns, currentInterns: $currentInterns, preferredPrograms: $preferredPrograms, companySupervisorIds: $companySupervisorIds, isActive: $isActive, acceptingInterns: $acceptingInterns, address: $address, city: $city, country: $country, postalCode: $postalCode, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.industry, industry) ||
                other.industry == industry) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.contactEmail, contactEmail) ||
                other.contactEmail == contactEmail) &&
            (identical(other.contactPhone, contactPhone) ||
                other.contactPhone == contactPhone) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.maxInterns, maxInterns) ||
                other.maxInterns == maxInterns) &&
            (identical(other.currentInterns, currentInterns) ||
                other.currentInterns == currentInterns) &&
            const DeepCollectionEquality()
                .equals(other._preferredPrograms, _preferredPrograms) &&
            const DeepCollectionEquality()
                .equals(other._companySupervisorIds, _companySupervisorIds) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.acceptingInterns, acceptingInterns) ||
                other.acceptingInterns == acceptingInterns) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
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
        name,
        industry,
        location,
        contactEmail,
        contactPhone,
        website,
        logoUrl,
        description,
        maxInterns,
        currentInterns,
        const DeepCollectionEquality().hash(_preferredPrograms),
        const DeepCollectionEquality().hash(_companySupervisorIds),
        isActive,
        acceptingInterns,
        address,
        city,
        country,
        postalCode,
        createdAt,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyModelImplCopyWith<_$CompanyModelImpl> get copyWith =>
      __$$CompanyModelImplCopyWithImpl<_$CompanyModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyModelImplToJson(
      this,
    );
  }
}

abstract class _CompanyModel implements CompanyModel {
  const factory _CompanyModel(
      {required final String id,
      required final String name,
      required final String industry,
      required final String location,
      final String? contactEmail,
      final String? contactPhone,
      final String? website,
      final String? logoUrl,
      final String? description,
      final int maxInterns,
      final int currentInterns,
      final List<String> preferredPrograms,
      final List<String> companySupervisorIds,
      final bool isActive,
      final bool acceptingInterns,
      final String? address,
      final String? city,
      final String? country,
      final String? postalCode,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$CompanyModelImpl;

  factory _CompanyModel.fromJson(Map<String, dynamic> json) =
      _$CompanyModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get industry;
  @override
  String get location;
  @override // Contact information
  String? get contactEmail;
  @override
  String? get contactPhone;
  @override
  String? get website;
  @override // Visual
  String? get logoUrl;
  @override
  String? get description;
  @override // Intern capacity tracking - NEW
  int get maxInterns;
  @override // How many interns they can take (0 = unlimited)
  int get currentInterns;
  @override // Current number of active interns
// Preferred programs - NEW
  List<String> get preferredPrograms;
  @override // e.g., ["Computer Science", "IT"]
// Company supervisor IDs - NEW
  List<String> get companySupervisorIds;
  @override // UIDs of company supervisors
// Status
  bool get isActive;
  @override
  bool get acceptingInterns;
  @override // NEW - Can toggle to stop accepting applications
// Additional info - NEW
  String? get address;
  @override
  String? get city;
  @override
  String? get country;
  @override
  String? get postalCode;
  @override // Timestamps
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$CompanyModelImplCopyWith<_$CompanyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
