import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../model/DustModel.dart';
import 'dart:convert';

class InitialController extends GetxController {

  final dustapiservice = DustApiService.create();

  RxList<DustModel> dusts = RxList<DustModel>([]);

  RxString DustLevel = ''.obs;
  RxString BarLevel = ''.obs;
  RxString Comment = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await CallDust();
    print('DustLevel: ${DustLevel} and ${BarLevel}');
  }

  Future<void> CallDust() async {
    final response = await dustapiservice.GetDust();
    final Iterable DustData = jsonDecode(response.body)['RealtimeCityAir']['row'];
    dusts.assignAll(DustData.map((e) => DustModel.fromJson(e)).toList());
    DustLevel.value = dusts.map((element) => element.pm10).
    reduce((a, b) => a+b/dusts.length).toStringAsFixed(2);
    var aa = double.tryParse(DustLevel.value);
    AirLevel(aa!);
  }

  void AirLevel(double concentration){
    if( concentration < 20.0){
      BarLevel.value = 'Line4';
      Comment.value = '아주맑음';
    }else if(concentration < 50.0){
      BarLevel.value = 'Line2';
      Comment.value = '맑음';
    }else if(concentration < 100.0){
      BarLevel.value = 'Line3';
      Comment.value = '보통';
    }else if(concentration < 150.0){
      BarLevel.value = 'Line8';
      Comment.value = '나쁨';
    }else if(concentration > 150){
      BarLevel.value = 'Line8';
      Comment.value = '아주나쁨';
      print(concentration);
    }
  }

}