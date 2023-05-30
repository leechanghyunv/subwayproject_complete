
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

  String LineStringA = '';
  String LineStringB = '';
  String number = '';

  String LineStringAT = '';
  String LineStringBT = '';
  String numberT = '';

  String LineStringAS = '';
  String LineStringBS = '';
  String numberS = '';

  String LineStringAU = '';
  String LineStringBU = '';
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

  void SavePositionT(List<SubwayModel> info, String Name) {
    final index = info.indexWhere((element) => element.name == Name);

    engNameT = info[index].engname;
    subwayNameT = info[index].name;
    lineT = info[index].line;
  }

  void SavePositionS(List<SubwayModel> info, String Name) {
    final index = info.indexWhere((element) => element.name == Name);

    latS = info[index].lat;
    lngS = info[index].lng;
    engNameS = info[index].engname;
    subwayNameS = info[index].name;
    lineS = info[index].line;
  }

  void SavePositionU(List<SubwayModel> info, String Name) {
    final index = info.indexWhere((element) => element.name == Name);

    latU = info[index].lat;
    lngU = info[index].lng;
    engNameU = info[index].engname;
    subwayNameU = info[index].name;
    lineU = info[index].line;
  }



  void RetriveLine(List<LineCode> LineList, String StringLine) {
    final index = LineList.indexWhere((element) => element.LineStringA == StringLine);

    LineStringA = LineList[index].LineStringA;
    LineStringB = LineList[index].LineStringB;
    number = LineList[index].number;
  }

  void RetriveLineT(List<LineCode> LineList, String StringLine) {
    final index = LineList.indexWhere((element) => element.LineStringA == StringLine);

    LineStringAT = LineList[index].LineStringA;
    LineStringBT = LineList[index].LineStringB;
    numberT = LineList[index].number;
  }

  void RetriveLineS(List<LineCode> LineList, String StringLine) {
    final index = LineList.indexWhere((element) => element.LineStringA == StringLine);

    LineStringAS = LineList[index].LineStringA;
    LineStringBS = LineList[index].LineStringB;
    numberS = LineList[index].number;
  }

  void RetriveLineU(List<LineCode> LineList, String StringLine) {
    final index = LineList.indexWhere((element) => element.LineStringA == StringLine);

    LineStringAU = LineList[index].LineStringA;
    LineStringBU = LineList[index].LineStringB;
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
