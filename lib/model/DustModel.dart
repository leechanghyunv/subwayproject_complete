import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chopper/chopper.dart';
part 'DustModel.g.dart';
part 'DustModel.freezed.dart';
part 'DustModel.chopper.dart';

@Freezed()
class DustModel with _$DustModel{
  const factory DustModel({
    @Default(0.0) @JsonKey(name: 'PM10') double pm10,
    @Default(0.0) @JsonKey(name: 'PM25') double pm25,
    @Default("정보없음") @JsonKey(name: 'IDEX_NM') String result,
    @Default("정보없음") @JsonKey(name: 'MSRSTE_NM') String region,
  }) = _DustModel;

  factory DustModel.fromJson(Map<String, Object?> json) => _$DustModelFromJson(json);
}
@ChopperApi()
abstract class DustApiService extends ChopperService{
  static DustApiService create(){
    String key = '4c6f72784b6272613735677166456d';
    final client = ChopperClient(
      baseUrl:Uri.parse('http://openapi.seoul.go.kr:8088/$key'),
      services: [_$DustApiService()],
    );
    return _$DustApiService(client);
  }

  @Get(path: '/json/RealtimeCityAir/1/25')
  Future<Response> GetDust();

}