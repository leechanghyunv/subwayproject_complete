import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chopper/chopper.dart';
part 'CodeModel.freezed.dart';
part 'CodeModel.g.dart';
part 'CodeModel.chopper.dart';

@Freezed()
class CodeModel with _$CodeModel{
  const factory CodeModel({
    @Default("정보없음") @JsonKey(name: 'STATION_CD') String stationCd,
    @Default("정보없음") @JsonKey(name: 'STATION_NM') String subwayname,
    @Default("정보없음") @JsonKey(name: 'LINE_NUM') String line,
    @Default("정보없음") @JsonKey(name: 'FR_CODE') String code,
  }) = _CodeModel;
  factory CodeModel.fromJson(Map<String, Object?> json) => _$CodeModelFromJson(json);
}

@ChopperApi()
abstract class CodeApiService extends ChopperService {
  static CodeApiService create() {
    String key = '4c6f72784b6272613735677166456d';
    final client = ChopperClient(
      baseUrl:Uri.parse('http://openapi.seoul.go.kr:8088/$key'),
      services: [_$CodeApiService()],
    );
    return _$CodeApiService(client);
  }
  @Get(path:'/json/SearchInfoBySubwayNameService/1/5/{name}')
  Future<Response> GetCode(@Path() String name);
}
/// http://openapi.seoul.go.kr:8088/4c6f72784b6272613735677166456d/json/SearchInfoBySubwayNameService/1/5/서울역

