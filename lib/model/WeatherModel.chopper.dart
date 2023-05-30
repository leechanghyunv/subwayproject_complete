// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherModel.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$WeatherApiService extends WeatherApiService {
  _$WeatherApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = WeatherApiService;

  @override
  Future<Response<dynamic>> GetWeather(
    String lat,
    String lng,
    String Key,
  ) {
    final Uri $url = Uri.parse('/weather?');
    final Map<String, dynamic> $params = <String, dynamic>{
      'lat': lat,
      'lon': lng,
      'appid': Key,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> GetDustData(
    String lat,
    String lng,
    String Key,
  ) {
    final Uri $url = Uri.parse('/air_pollution?');
    final Map<String, dynamic> $params = <String, dynamic>{
      'lat': lat,
      'lon': lng,
      'appid': Key,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
