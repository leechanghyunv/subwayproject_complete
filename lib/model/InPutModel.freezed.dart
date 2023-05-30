// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'InPutModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InfoModel _$InfoModelFromJson(Map<String, dynamic> json) {
  return _InfoModel.fromJson(json);
}

/// @nodoc
mixin _$InfoModel {
  String get stringNumber => throw _privateConstructorUsedError;
  String get subwayname => throw _privateConstructorUsedError;
  String get linetoNum => throw _privateConstructorUsedError;
  String get engname => throw _privateConstructorUsedError;
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get convert => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InfoModelCopyWith<InfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfoModelCopyWith<$Res> {
  factory $InfoModelCopyWith(InfoModel value, $Res Function(InfoModel) then) =
      _$InfoModelCopyWithImpl<$Res, InfoModel>;
  @useResult
  $Res call(
      {String stringNumber,
      String subwayname,
      String linetoNum,
      String engname,
      double lat,
      double lng,
      String code,
      String convert});
}

/// @nodoc
class _$InfoModelCopyWithImpl<$Res, $Val extends InfoModel>
    implements $InfoModelCopyWith<$Res> {
  _$InfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stringNumber = null,
    Object? subwayname = null,
    Object? linetoNum = null,
    Object? engname = null,
    Object? lat = null,
    Object? lng = null,
    Object? code = null,
    Object? convert = null,
  }) {
    return _then(_value.copyWith(
      stringNumber: null == stringNumber
          ? _value.stringNumber
          : stringNumber // ignore: cast_nullable_to_non_nullable
              as String,
      subwayname: null == subwayname
          ? _value.subwayname
          : subwayname // ignore: cast_nullable_to_non_nullable
              as String,
      linetoNum: null == linetoNum
          ? _value.linetoNum
          : linetoNum // ignore: cast_nullable_to_non_nullable
              as String,
      engname: null == engname
          ? _value.engname
          : engname // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      convert: null == convert
          ? _value.convert
          : convert // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InfoModelCopyWith<$Res> implements $InfoModelCopyWith<$Res> {
  factory _$$_InfoModelCopyWith(
          _$_InfoModel value, $Res Function(_$_InfoModel) then) =
      __$$_InfoModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String stringNumber,
      String subwayname,
      String linetoNum,
      String engname,
      double lat,
      double lng,
      String code,
      String convert});
}

/// @nodoc
class __$$_InfoModelCopyWithImpl<$Res>
    extends _$InfoModelCopyWithImpl<$Res, _$_InfoModel>
    implements _$$_InfoModelCopyWith<$Res> {
  __$$_InfoModelCopyWithImpl(
      _$_InfoModel _value, $Res Function(_$_InfoModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stringNumber = null,
    Object? subwayname = null,
    Object? linetoNum = null,
    Object? engname = null,
    Object? lat = null,
    Object? lng = null,
    Object? code = null,
    Object? convert = null,
  }) {
    return _then(_$_InfoModel(
      stringNumber: null == stringNumber
          ? _value.stringNumber
          : stringNumber // ignore: cast_nullable_to_non_nullable
              as String,
      subwayname: null == subwayname
          ? _value.subwayname
          : subwayname // ignore: cast_nullable_to_non_nullable
              as String,
      linetoNum: null == linetoNum
          ? _value.linetoNum
          : linetoNum // ignore: cast_nullable_to_non_nullable
              as String,
      engname: null == engname
          ? _value.engname
          : engname // ignore: cast_nullable_to_non_nullable
              as String,
      lat: null == lat
          ? _value.lat
          : lat // ignore: cast_nullable_to_non_nullable
              as double,
      lng: null == lng
          ? _value.lng
          : lng // ignore: cast_nullable_to_non_nullable
              as double,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      convert: null == convert
          ? _value.convert
          : convert // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InfoModel implements _InfoModel {
  const _$_InfoModel(
      {required this.stringNumber,
      required this.subwayname,
      required this.linetoNum,
      required this.engname,
      required this.lat,
      required this.lng,
      required this.code,
      required this.convert});

  factory _$_InfoModel.fromJson(Map<String, dynamic> json) =>
      _$$_InfoModelFromJson(json);

  @override
  final String stringNumber;
  @override
  final String subwayname;
  @override
  final String linetoNum;
  @override
  final String engname;
  @override
  final double lat;
  @override
  final double lng;
  @override
  final String code;
  @override
  final String convert;

  @override
  String toString() {
    return 'InfoModel(stringNumber: $stringNumber, subwayname: $subwayname, linetoNum: $linetoNum, engname: $engname, lat: $lat, lng: $lng, code: $code, convert: $convert)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InfoModel &&
            (identical(other.stringNumber, stringNumber) ||
                other.stringNumber == stringNumber) &&
            (identical(other.subwayname, subwayname) ||
                other.subwayname == subwayname) &&
            (identical(other.linetoNum, linetoNum) ||
                other.linetoNum == linetoNum) &&
            (identical(other.engname, engname) || other.engname == engname) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.convert, convert) || other.convert == convert));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, stringNumber, subwayname,
      linetoNum, engname, lat, lng, code, convert);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InfoModelCopyWith<_$_InfoModel> get copyWith =>
      __$$_InfoModelCopyWithImpl<_$_InfoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InfoModelToJson(
      this,
    );
  }
}

abstract class _InfoModel implements InfoModel {
  const factory _InfoModel(
      {required final String stringNumber,
      required final String subwayname,
      required final String linetoNum,
      required final String engname,
      required final double lat,
      required final double lng,
      required final String code,
      required final String convert}) = _$_InfoModel;

  factory _InfoModel.fromJson(Map<String, dynamic> json) =
      _$_InfoModel.fromJson;

  @override
  String get stringNumber;
  @override
  String get subwayname;
  @override
  String get linetoNum;
  @override
  String get engname;
  @override
  double get lat;
  @override
  double get lng;
  @override
  String get code;
  @override
  String get convert;
  @override
  @JsonKey(ignore: true)
  _$$_InfoModelCopyWith<_$_InfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}
