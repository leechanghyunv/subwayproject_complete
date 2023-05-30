// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DustModel.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$DustApiService extends DustApiService {
  _$DustApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = DustApiService;

  @override
  Future<Response<dynamic>> GetDust() {
    final Uri $url = Uri.parse('/json/RealtimeCityAir/1/25');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
