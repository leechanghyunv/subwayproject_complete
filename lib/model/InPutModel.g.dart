// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'InPutModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InfoModel _$$_InfoModelFromJson(Map<String, dynamic> json) => _$_InfoModel(
      stringNumber: json['stringNumber'] as String,
      subwayname: json['subwayname'] as String,
      linetoNum: json['linetoNum'] as String,
      engname: json['engname'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      code: json['code'] as String,
      convert: json['convert'] as String,
    );

Map<String, dynamic> _$$_InfoModelToJson(_$_InfoModel instance) =>
    <String, dynamic>{
      'stringNumber': instance.stringNumber,
      'subwayname': instance.subwayname,
      'linetoNum': instance.linetoNum,
      'engname': instance.engname,
      'lat': instance.lat,
      'lng': instance.lng,
      'code': instance.code,
      'convert': instance.convert,
    };
