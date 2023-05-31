import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import '../model/TableModel.dart';
import 'dart:convert';

class TableController extends GetxController {

  final apiservice = ApiService.create();

  RxList<TableModel> tableA = RxList<TableModel>([]);
  RxList<TableModel> tableB = RxList<TableModel>([]);

  /// 앞에 1은 평일 2는 주말 3은 공휴일  // 뒤에 1은 상행 2는 하행
  /// "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"

  final String eee = DateFormat('EEE').format(DateTime.now());
  Future<void> callData1(String code) async {
    callday(eee);
    final response = await apiservice.GetTable(code,callday(eee),'1');
    final Iterable TableData = jsonDecode(response.body)['SearchSTNTimeTableByIDService']['row'];
    tableA.assignAll(TableData.map((e) => TableModel.fromJson(e)).toList());
  }

  Future<void> callData2(String code) async {
    callday(eee);
    final response = await apiservice.GetTable(code,callday(eee),'2');
    final Iterable TableData = jsonDecode(response.body)['SearchSTNTimeTableByIDService']['row'];
    tableB.assignAll(TableData.map((e) => TableModel.fromJson(e)).toList());
  }

String callday(String day){
    if(day == "Sat"){
      return '2';
    } else if(day == "Sun") {
      return '2';
    } else {
      return '1';
    }
}



}