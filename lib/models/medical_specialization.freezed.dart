// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medical_specialization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MedicalSpecialization _$MedicalSpecializationFromJson(
    Map<String, dynamic> json) {
  return _MedicalSpecialization.fromJson(json);
}

/// @nodoc
mixin _$MedicalSpecialization {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;

  /// Serializes this MedicalSpecialization to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MedicalSpecialization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MedicalSpecializationCopyWith<MedicalSpecialization> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MedicalSpecializationCopyWith<$Res> {
  factory $MedicalSpecializationCopyWith(MedicalSpecialization value,
          $Res Function(MedicalSpecialization) then) =
      _$MedicalSpecializationCopyWithImpl<$Res, MedicalSpecialization>;
  @useResult
  $Res call({String id, String name, String description, String? icon});
}

/// @nodoc
class _$MedicalSpecializationCopyWithImpl<$Res,
        $Val extends MedicalSpecialization>
    implements $MedicalSpecializationCopyWith<$Res> {
  _$MedicalSpecializationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MedicalSpecialization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? icon = freezed,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MedicalSpecializationImplCopyWith<$Res>
    implements $MedicalSpecializationCopyWith<$Res> {
  factory _$$MedicalSpecializationImplCopyWith(
          _$MedicalSpecializationImpl value,
          $Res Function(_$MedicalSpecializationImpl) then) =
      __$$MedicalSpecializationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String description, String? icon});
}

/// @nodoc
class __$$MedicalSpecializationImplCopyWithImpl<$Res>
    extends _$MedicalSpecializationCopyWithImpl<$Res,
        _$MedicalSpecializationImpl>
    implements _$$MedicalSpecializationImplCopyWith<$Res> {
  __$$MedicalSpecializationImplCopyWithImpl(_$MedicalSpecializationImpl _value,
      $Res Function(_$MedicalSpecializationImpl) _then)
      : super(_value, _then);

  /// Create a copy of MedicalSpecialization
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? icon = freezed,
  }) {
    return _then(_$MedicalSpecializationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MedicalSpecializationImpl implements _MedicalSpecialization {
  const _$MedicalSpecializationImpl(
      {required this.id,
      required this.name,
      required this.description,
      this.icon});

  factory _$MedicalSpecializationImpl.fromJson(Map<String, dynamic> json) =>
      _$$MedicalSpecializationImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String? icon;

  @override
  String toString() {
    return 'MedicalSpecialization(id: $id, name: $name, description: $description, icon: $icon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MedicalSpecializationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, icon);

  /// Create a copy of MedicalSpecialization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MedicalSpecializationImplCopyWith<_$MedicalSpecializationImpl>
      get copyWith => __$$MedicalSpecializationImplCopyWithImpl<
          _$MedicalSpecializationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MedicalSpecializationImplToJson(
      this,
    );
  }
}

abstract class _MedicalSpecialization implements MedicalSpecialization {
  const factory _MedicalSpecialization(
      {required final String id,
      required final String name,
      required final String description,
      final String? icon}) = _$MedicalSpecializationImpl;

  factory _MedicalSpecialization.fromJson(Map<String, dynamic> json) =
      _$MedicalSpecializationImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String? get icon;

  /// Create a copy of MedicalSpecialization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MedicalSpecializationImplCopyWith<_$MedicalSpecializationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
