import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/WeatherModel.dart';
import 'Geolocation.dart';
import 'SvgController.dart';

class WeatherController extends GetxController {

  String key2 = '391af738f3d6aea930da389c0e6041ff';

  final weatherapiservice = WeatherApiService.create();

  RxList<Weather> Weathermain = RxList<Weather>([]);
  Rx<Main> Weathertemp = Rx<Main>(Main());

  final svgicon = Get.put(SvgModelContoller());
  final geolocator = Get.put(GetLocation());

  late Widget weathericon = Icon(Icons.question_mark,size: 20,);

  RxDouble temperature = 0.0.obs;
  RxString des = ''.obs;
  String Lat = '';
  String Lng = '';

  @override
  void onInit() async {
    super.onInit();
    await CallWeather();
  }

  Future<void> CallWeather() async {
    Lat = geolocator.lat.toString();
    Lng = geolocator.lng.toString();
    final response = await weatherapiservice.GetWeather(Lat, Lng, key2);
    final Iterable WeatherData = jsonDecode(response.body)['weather'];
    final WeatherMain = Main.fromJson(jsonDecode(response.body)['main']); /// class는 Iterable을 허용하지 않나봐
    Weathermain.assignAll(WeatherData.map((e) => Weather.fromJson(e)).toList());
    temperature.value = WeatherMain.temp- 273.15;
    des.value = Weathermain[0].description;
    weathericon = svgicon.getWeatherIcon(Weathermain[0].id);
  }
}