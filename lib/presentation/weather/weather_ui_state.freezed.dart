// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_ui_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WeatherUiState {
  Weather? get weather => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeatherUiStateCopyWith<WeatherUiState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherUiStateCopyWith<$Res> {
  factory $WeatherUiStateCopyWith(
          WeatherUiState value, $Res Function(WeatherUiState) then) =
      _$WeatherUiStateCopyWithImpl<$Res, WeatherUiState>;
  @useResult
  $Res call({Weather? weather});
}

/// @nodoc
class _$WeatherUiStateCopyWithImpl<$Res, $Val extends WeatherUiState>
    implements $WeatherUiStateCopyWith<$Res> {
  _$WeatherUiStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weather = freezed,
  }) {
    return _then(_value.copyWith(
      weather: freezed == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as Weather?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherUiStateImplCopyWith<$Res>
    implements $WeatherUiStateCopyWith<$Res> {
  factory _$$WeatherUiStateImplCopyWith(_$WeatherUiStateImpl value,
          $Res Function(_$WeatherUiStateImpl) then) =
      __$$WeatherUiStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Weather? weather});
}

/// @nodoc
class __$$WeatherUiStateImplCopyWithImpl<$Res>
    extends _$WeatherUiStateCopyWithImpl<$Res, _$WeatherUiStateImpl>
    implements _$$WeatherUiStateImplCopyWith<$Res> {
  __$$WeatherUiStateImplCopyWithImpl(
      _$WeatherUiStateImpl _value, $Res Function(_$WeatherUiStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weather = freezed,
  }) {
    return _then(_$WeatherUiStateImpl(
      weather: freezed == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as Weather?,
    ));
  }
}

/// @nodoc

class _$WeatherUiStateImpl implements _WeatherUiState {
  const _$WeatherUiStateImpl({required this.weather});

  @override
  final Weather? weather;

  @override
  String toString() {
    return 'WeatherUiState(weather: $weather)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherUiStateImpl &&
            const DeepCollectionEquality().equals(other.weather, weather));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(weather));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherUiStateImplCopyWith<_$WeatherUiStateImpl> get copyWith =>
      __$$WeatherUiStateImplCopyWithImpl<_$WeatherUiStateImpl>(
          this, _$identity);
}

abstract class _WeatherUiState implements WeatherUiState {
  const factory _WeatherUiState({required final Weather? weather}) =
      _$WeatherUiStateImpl;

  @override
  Weather? get weather;
  @override
  @JsonKey(ignore: true)
  _$$WeatherUiStateImplCopyWith<_$WeatherUiStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
