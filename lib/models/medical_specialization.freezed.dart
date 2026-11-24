// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'medical_specialization.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MedicalSpecialization {
  String get id;
  String get name;
  String get description;
  String? get icon;

  /// Create a copy of MedicalSpecialization
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MedicalSpecializationCopyWith<MedicalSpecialization> get copyWith =>
      _$MedicalSpecializationCopyWithImpl<MedicalSpecialization>(
          this as MedicalSpecialization, _$identity);

  /// Serializes this MedicalSpecialization to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MedicalSpecialization &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, icon);

  @override
  String toString() {
    return 'MedicalSpecialization(id: $id, name: $name, description: $description, icon: $icon)';
  }
}

/// @nodoc
abstract mixin class $MedicalSpecializationCopyWith<$Res> {
  factory $MedicalSpecializationCopyWith(MedicalSpecialization value,
          $Res Function(MedicalSpecialization) _then) =
      _$MedicalSpecializationCopyWithImpl;
  @useResult
  $Res call({String id, String name, String description, String? icon});
}

/// @nodoc
class _$MedicalSpecializationCopyWithImpl<$Res>
    implements $MedicalSpecializationCopyWith<$Res> {
  _$MedicalSpecializationCopyWithImpl(this._self, this._then);

  final MedicalSpecialization _self;
  final $Res Function(MedicalSpecialization) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MedicalSpecialization].
extension MedicalSpecializationPatterns on MedicalSpecialization {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MedicalSpecialization value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MedicalSpecialization() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MedicalSpecialization value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicalSpecialization():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MedicalSpecialization value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicalSpecialization() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, String name, String description, String? icon)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MedicalSpecialization() when $default != null:
        return $default(_that.id, _that.name, _that.description, _that.icon);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, String name, String description, String? icon)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicalSpecialization():
        return $default(_that.id, _that.name, _that.description, _that.icon);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, String name, String description, String? icon)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MedicalSpecialization() when $default != null:
        return $default(_that.id, _that.name, _that.description, _that.icon);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MedicalSpecialization implements MedicalSpecialization {
  const _MedicalSpecialization(
      {required this.id, required this.name, this.description = '', this.icon});
  factory _MedicalSpecialization.fromJson(Map<String, dynamic> json) =>
      _$MedicalSpecializationFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  final String? icon;

  /// Create a copy of MedicalSpecialization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MedicalSpecializationCopyWith<_MedicalSpecialization> get copyWith =>
      __$MedicalSpecializationCopyWithImpl<_MedicalSpecialization>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MedicalSpecializationToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MedicalSpecialization &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description, icon);

  @override
  String toString() {
    return 'MedicalSpecialization(id: $id, name: $name, description: $description, icon: $icon)';
  }
}

/// @nodoc
abstract mixin class _$MedicalSpecializationCopyWith<$Res>
    implements $MedicalSpecializationCopyWith<$Res> {
  factory _$MedicalSpecializationCopyWith(_MedicalSpecialization value,
          $Res Function(_MedicalSpecialization) _then) =
      __$MedicalSpecializationCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String name, String description, String? icon});
}

/// @nodoc
class __$MedicalSpecializationCopyWithImpl<$Res>
    implements _$MedicalSpecializationCopyWith<$Res> {
  __$MedicalSpecializationCopyWithImpl(this._self, this._then);

  final _MedicalSpecialization _self;
  final $Res Function(_MedicalSpecialization) _then;

  /// Create a copy of MedicalSpecialization
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? icon = freezed,
  }) {
    return _then(_MedicalSpecialization(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      icon: freezed == icon
          ? _self.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
