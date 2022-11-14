// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sign_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Sign _$SignFromJson(Map<String, dynamic> json) {
  return _Sign.fromJson(json);
}

/// @nodoc
mixin _$Sign {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignCopyWith<Sign> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignCopyWith<$Res> {
  factory $SignCopyWith(Sign value, $Res Function(Sign) then) =
      _$SignCopyWithImpl<$Res, Sign>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$SignCopyWithImpl<$Res, $Val extends Sign>
    implements $SignCopyWith<$Res> {
  _$SignCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SignCopyWith<$Res> implements $SignCopyWith<$Res> {
  factory _$$_SignCopyWith(_$_Sign value, $Res Function(_$_Sign) then) =
      __$$_SignCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$_SignCopyWithImpl<$Res> extends _$SignCopyWithImpl<$Res, _$_Sign>
    implements _$$_SignCopyWith<$Res> {
  __$$_SignCopyWithImpl(_$_Sign _value, $Res Function(_$_Sign) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$_Sign(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Sign implements _Sign {
  _$_Sign({required this.email, required this.password});

  factory _$_Sign.fromJson(Map<String, dynamic> json) => _$$_SignFromJson(json);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'Sign(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Sign &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SignCopyWith<_$_Sign> get copyWith =>
      __$$_SignCopyWithImpl<_$_Sign>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SignToJson(
      this,
    );
  }
}

abstract class _Sign implements Sign {
  factory _Sign({required final String email, required final String password}) =
      _$_Sign;

  factory _Sign.fromJson(Map<String, dynamic> json) = _$_Sign.fromJson;

  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_SignCopyWith<_$_Sign> get copyWith => throw _privateConstructorUsedError;
}
