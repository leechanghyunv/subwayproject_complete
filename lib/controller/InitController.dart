import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../model/DustModel.dart';
import 'dart:convert';

class InitialController extends GetxController {

  final dustapiservice = DustApiService.create();

  RxList<DustModel> dusts = RxList<DustModel>([]);

  RxString dustLevel = ''.obs;
  RxString barLevel = ''.obs;
  RxString Comment = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await callDust();
    print('DustLevel: ${dustLevel} and ${barLevel}');
  }

  Future<void> callDust() async {
    final response = await dustapiservice.GetDust();
    final Iterable DustData = jsonDecode(response.body)['RealtimeCityAir']['row'];
    dusts.assignAll(DustData.map((e) => DustModel.fromJson(e)).toList());
    dustLevel.value = dusts.map((element) => element.pm10).
    reduce((a, b) => a+b/dusts.length).toStringAsFixed(2);
    var aa = double.tryParse(dustLevel.value);
    airLevel(aa!);
  }

  void airLevel(double concentration){
    if( concentration < 20.0){
      barLevel.value = 'Line4';
      Comment.value = '아주맑음';
    }else if(concentration < 50.0){
      barLevel.value = 'Line2';
      Comment.value = '맑음';
    }else if(concentration < 100.0){
      barLevel.value = 'Line3';
      Comment.value = '보통';
    }else if(concentration < 150.0){
      barLevel.value = 'Line8';
      Comment.value = '나쁨';
    }else if(concentration > 150){
      barLevel.value = 'Line8';
      Comment.value = '아주나쁨';
      print(concentration);
    }
  }

}