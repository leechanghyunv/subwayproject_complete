
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../model/ArrivalModel.dart';
import '../model/CodeModel.dart';
import '../model/Xmodel.dart';
import 'RetrieveData.dart';

class Controller extends GetxController {

  final arrivalservice = ArrivalApiService.create();


  final codeapiservice = CodeApiService.create();


  RxList<ArrivalModel> arrival = RxList<ArrivalModel>([]);

  RxList<CodeModel> codes = RxList<CodeModel>([]);

  final Datas = Get.put(Retrieve());

  String CodeResult = '';


  Future<void> CallArrival(String name) async {
    try{
      final response = await arrivalservice.GetArrival(name);
      final Iterable SubwayData = jsonDecode(response.body)['realtimeArrivalList'];
      arrival.assignAll(SubwayData.map((e) => ArrivalModel.fromJson(e)).toList());
    }catch(e){
      Fluttertoast.showToast(
          msg:'실시간 위치정보를 받을 수 없습니다.',
          gravity: ToastGravity.CENTER);
    }
  }



  Future<void> CallCode(String name, String line) async {
    if(name == '서울'){
      name = '서울역';
    }
    final nameWithoutParentheses = name.replaceAll(RegExp(r'\([^()]*\)'), '');
    Datas.RetriveLine(LineList, line);
    var lineB = Datas.LineStringB;
    final response = await codeapiservice.GetCode(nameWithoutParentheses);
    final Iterable CodeData = jsonDecode(response.body)['SearchInfoBySubwayNameService']['row'];
    codes.assignAll(CodeData.map((e) => CodeModel.fromJson(e)).toList());
    final index = codes.indexWhere((element) => element.line == lineB);
    CodeResult = codes[index].stationCd;
  }
}