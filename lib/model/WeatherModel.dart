import 'package:chopper/chopper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'WeatherModel.freezed.dart';
part 'WeatherModel.g.dart';
part 'WeatherModel.chopper.dart';


@Freezed()
class Main with _$Main{
  const factory Main({
    @Default(0.0) double temp,
    @Default(0.0) double feelsLike,
    @Default(0.0) double tempMin,
    @Default(0.0) double tempMax,
  }) = _Main;
  factory Main.fromJson(Map<String, Object?> json) => _$MainFromJson(json);
}

@Freezed()
class Weather with _$Weather{
  const factory Weather({
    @Default(0) int id,
    @Default("정보없음") String main,
    @Default("정보없음") String description,
    @Default("정보없음") String icon,
  }) =_Weather;

  factory Weather.fromJson(Map<String, Object?> json) => _$WeatherFromJson(json);
}
@ChopperApi()
abstract class WeatherApiService extends ChopperService {
  static WeatherApiService create() {

    final client = ChopperClient(
      baseUrl:Uri.parse('http://api.openweathermap.org/data/2.5'),
      services: [_$WeatherApiService()],
    );
    return _$WeatherApiService(client);
  }

  @Get(path: '/weather?')
  Future<Response> GetWeather(
      @Query('lat') String lat,
      @Query('lon') String lng,
      @Query('appid') String Key,
      );

  @Get(path: '/air_pollution?')
  Future<Response> GetDustData(
      @Query('lat') String lat,
      @Query('lon') String lng,
      @Query('appid') String Key,
      );
}