import 'package:freezed_annotation/freezed_annotation.dart';
part 'InPutModel.freezed.dart';
part 'InPutModel.g.dart';

@Freezed()
class InfoModel with _$InfoModel {
  const factory InfoModel({
    required String stringNumber,
    required String subwayname,
    required String linetoNum,
    required String engname,
    required double lat,
    required double lng,
    required String code,
    required String convert,
  }) = _InfoModel;
  factory InfoModel.fromJson(Map<String, Object?> json) => _$InfoModelFromJson(json);
}

