import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chopper/chopper.dart';
part 'ArrivalModel.freezed.dart';
part 'ArrivalModel.g.dart';
part 'ArrivalModel.chopper.dart';

@Freezed()
class ArrivalModel with _$ArrivalModel{
  const factory ArrivalModel({
    @Default("정보없음") String subwayId, /// 호선번호 1001,1002 ~~
    @Default("정보없음") String updnLine, /// 상행,하행,내선,외선
    @Default("정보없음") String trainLineNm, /// "방화행 - 마장방면",
    @Default("정보없음") String statnFid,   /// 이전지하철역ID - 1004 00 0427 - 4호선 회현 0427
    @Default("정보없음") String statnTid,   /// 다음지하철역ID - 1004 00 0425
    @Default("정보없음") String statnId,   /// 지하철역ID - 1004 00 0426
    @Default("정보없음") String statnNm,  /// 지하철역명
    @Default("정보없음") String subwayList, /// 지하철역 호선 리스트 "1001,1004,1063,1065",
    @Default("정보없음") String btrainSttus,  /// ITX, 급행
    @Default("정보없음") String btrainNo, /// 열차번호
    @Default("정보없음") String bstatnNm, /// 종착
    @Default("정보없음") String arvlMsg2, /// 도착메시지
    @Default("정보없음") String arvlCd, /// 실시간 열차 상태
  }) = _ArrivalModel;
  factory ArrivalModel.fromJson(Map<String, Object?> json) => _$ArrivalModelFromJson(json);
}
@ChopperApi()
abstract class ArrivalApiService extends ChopperService{
  static ArrivalApiService create(){
    String key = '4c6f72784b6272613735677166456d';
    final client = ChopperClient(
      baseUrl: Uri.parse('http://swopenapi.seoul.go.kr/api/subway/$key'),
      services: [_$ArrivalApiService()],
    );
    return _$ArrivalApiService(client);
  }

  @Get(path: '/json/realtimeStationArrival/0/16/{name}')
  Future<Response> GetArrival(@Path() String name);
}

///http://swopenapi.seoul.go.kr/api/subway/4c6f72784b6272613735677166456d/json/realtimeStationArrival/0/16/서울

