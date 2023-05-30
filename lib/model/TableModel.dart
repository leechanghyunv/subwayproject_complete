import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chopper/chopper.dart';
part 'TableModel.g.dart';
part 'TableModel.freezed.dart';
part 'TableModel.chopper.dart';

@Freezed()
class TableModel with _$TableModel{
  const factory TableModel({
    @Default("정보없음") @JsonKey(name: 'STATION_CD') String stationcd,
    @Default("정보없음") @JsonKey(name: 'STATION_NM') String stationnm,
    @Default("정보없음") @JsonKey(name: 'ARRIVETIME')  String arrivetime,
    @Default("정보없음") @JsonKey(name: 'ORIGINSTATION') String originstation,
    @Default("정보없음") @JsonKey(name: 'SUBWAYSNAME') String subwaysname,
    @Default("정보없음") @JsonKey(name: 'SUBWAYENAME') String subwayename,
    @Default(EXPRESS.GENERAL) @JsonKey(name: 'EXPRESS_YN') EXPRESS express,
  }) = _TableModel;
  factory TableModel.fromJson(Map<String, Object?> json) => _$TableModelFromJson(json);
}
@JsonEnum(valueField: 'initial')
enum EXPRESS {
  GENERAL('G'),
  DIRECT('D');

  final String initial;
  const EXPRESS(this.initial);
}

@ChopperApi()
abstract class ApiService extends ChopperService {
  static ApiService create() {
    String key = '4c6f72784b6272613735677166456d';
    final client = ChopperClient(
      baseUrl:Uri.parse('http://openAPI.seoul.go.kr:8088/$key'),
      services: [_$ApiService()],
    );
    return _$ApiService(client);
  }
  @Get(path: '/json/SearchSTNTimeTableByIDService/1/500/{code}/{week}/{updown}')
  Future<Response> GetTable(
      @Path() String code,
      @Path() String week,
      @Path() String updown
      );
}