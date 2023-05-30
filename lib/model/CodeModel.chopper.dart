// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CodeModel.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$CodeApiService extends CodeApiService {
  _$CodeApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CodeApiService;

  @override
  Future<Response<dynamic>> GetCode(String name) {
    final Uri $url =
        Uri.parse('/json/SearchInfoBySubwayNameService/1/5/${name}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
