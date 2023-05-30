// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ArrivalModel.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$ArrivalApiService extends ArrivalApiService {
  _$ArrivalApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ArrivalApiService;

  @override
  Future<Response<dynamic>> GetArrival(String name) {
    final Uri $url = Uri.parse('/json/realtimeStationArrival/0/16/${name}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
