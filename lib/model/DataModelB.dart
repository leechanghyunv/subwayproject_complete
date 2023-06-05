import 'package:freezed_annotation/freezed_annotation.dart';
part 'DataModelB.freezed.dart';
part 'DataModelB.g.dart';

@Freezed()
class LineCode with _$LineCode{
  const factory LineCode({
    required String lineStringA,
    required String lineStringB,
    required String number,
  }) = _LineCode;
  factory LineCode.fromJson(Map<String, Object?> json) => _$LineCodeFromJson(json);
}

List<LineCode> lineDataList = [
  const LineCode(lineStringA:"Line1",lineStringB:"01호선",number: '1001',),
  const LineCode(lineStringA:"Line2",lineStringB:"02호선",number: '1002',),
  const LineCode(lineStringA:"Line3",lineStringB:"03호선",number: '1003',),
  const LineCode(lineStringA:"Line4",lineStringB:"04호선",number: '1004',),
  const LineCode(lineStringA:"Line5",lineStringB:"05호선",number: '1005',),
  const LineCode(lineStringA:"Line6",lineStringB:"06호선",number: '1006',),
  const LineCode(lineStringA:"Line7",lineStringB:"07호선",number: '1007',),
  const LineCode(lineStringA:"Line8",lineStringB:"08호선",number: '1008',),
  const LineCode(lineStringA:"Line9",lineStringB:"09호선",number: '1009',),
  const LineCode(lineStringA:"신분당",lineStringB:"신분당선",number: '1077',),
  const LineCode(lineStringA:"수인분당",lineStringB:"수인분당선",number: '1075',),
  const LineCode(lineStringA:"경의중앙",lineStringB:"경의중앙선",number: '1063',),
  const LineCode(lineStringA:"우이신설",lineStringB:"우이신설경전철",number: '1092',),
  const LineCode(lineStringA:"공항",lineStringB:"공항철도",number: '1065',),
  const LineCode(lineStringA:"신림",lineStringB:"신림선",number: '',),

];