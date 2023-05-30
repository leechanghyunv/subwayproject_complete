
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/Xmodel.dart';

class Retrieve extends GetxController {

  double lat1 = 0.0;
  double lng1 = 0.0;

  double latS = 0.0;
  double lngS = 0.0;

  double latU = 0.0;
  double lngU = 0.0;

  List<String> line = [];
  String engName = '';
  String subwayName = 'SEOUL';

  List<String> lineT = [];
  String engNameT = '';
  String subwayNameT = 'SEOUL';

  List<String> lineS = [];
  String engNameS = '';
  String subwayNameS = 'SEOUL';

  List<String> lineU = [];
  String engNameU = '';
  String subwayNameU = 'SEOUL';

  String lineStringA = '';
  String lineStringB = '';
  String number = '';

  String lineStringAT = '';
  String lineStringBT = '';
  String numberT = '';

  String lineStringAS = '';
  String lineStringBS = '';
  String numberS = '';

  String lineStringAU = '';
  String lineStringBU = '';
  String numberU = '';

  bool showTable = false;

  void SavePosition(List<SubwayModel> info, String Name) {
    final index = info.indexWhere((element) => element.name == Name);

    lat1 = info[index].lat;
    lng1 = info[index].lng;
    engName = info[index].engname;
    subwayName = info[index].name;
    line = info[index].line;
  }

  void savePositionT(List<SubwayModel> info, String Name) {
    final index = info.indexWhere((element) => element.name == Name);

    engNameT = info[index].engname;
    subwayNameT = info[index].name;
    lineT = info[index].line;
  }

  void savePositionS(List<SubwayModel> info, String Name) {
    final index = info.indexWhere((element) => element.name == Name);

    latS = info[index].lat;
    lngS = info[index].lng;
    engNameS = info[index].engname;
    subwayNameS = info[index].name;
    lineS = info[index].line;
  }

  void savePositionU(List<SubwayModel> info, String Name) {
    final index = info.indexWhere((element) => element.name == Name);

    latU = info[index].lat;
    lngU = info[index].lng;
    engNameU = info[index].engname;
    subwayNameU = info[index].name;
    lineU = info[index].line;
  }



  void retriveLine(List<LineCode> LineList, String StringLine) {
    final index = LineList.indexWhere((element) => element.LineStringA == StringLine);

    lineStringA = LineList[index].LineStringA;
    lineStringB = LineList[index].LineStringB;
    number = LineList[index].number;
  }

  void retriveLineT(List<LineCode> LineList, String StringLine) {
    final index = LineList.indexWhere((element) => element.LineStringA == StringLine);

    lineStringAT = LineList[index].LineStringA;
    lineStringBT = LineList[index].LineStringB;
    numberT = LineList[index].number;
  }

  void retriveLineS(List<LineCode> LineList, String StringLine) {
    final index = LineList.indexWhere((element) => element.LineStringA == StringLine);

    lineStringAS = LineList[index].LineStringA;
    lineStringBS = LineList[index].LineStringB;
    numberS = LineList[index].number;
  }

  void retriveLineU(List<LineCode> LineList, String StringLine) {
    final index = LineList.indexWhere((element) => element.LineStringA == StringLine);

    lineStringAU = LineList[index].LineStringA;
    lineStringBU = LineList[index].LineStringB;
    numberU = LineList[index].number;
  }

  void convertor(int number) {
    if (number == 0) {
      showTable = !showTable;
    } else if (number == 1) {
      showTable = !showTable;
    } else if (number == 2) {
      showTable = !showTable;
    } else {showTable = false;}
  }

}
