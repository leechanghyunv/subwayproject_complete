import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/ApiController.dart';
import '../controller/RetrieveData.dart';
import '../custom/TextFrame.dart';
import '../main.dart';
import '../model/DataModelB.dart';
import '../model/LineModel.dart';
import '../parts/QrContainer.dart';
import 'MainPage.dart';

class LinePickerA extends StatefulWidget {

  final String subway;

  const LinePickerA({Key? key, required this.subway}) : super(key: key);

  @override
  State<LinePickerA> createState() => _LinePickerAState();
}

class _LinePickerAState extends State<LinePickerA> {

  List<LineModel> selectedList = [];

  final datas = Get.put(Retrieve());
  final seoul = Get.put(Controller());

  @override
  void initState() {
    super.initState();
    selectedList = datas.line.map((e) => LineModel(name: e)).toList();
    seoul.callArrival(widget.subway);
    print(widget.subway);
  }

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    return Container(
      height: datas.line.length == 1 ? 270
          : datas.line.length == 2 ? 320
          : datas.line.length == 3 ? 370
          : datas.line.length == 4 ? 420
          : datas.line.length == 5 ? 470
          : 520,
      color: Colors.white,
      alignment: Alignment.center,
      width: double.maxFinite,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: DialogDesign(
              designText: '${datas.subwayName}역',
            ),
          ),
          Container(
            color: Colors.grey[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                  selectedList.length,
                      (index) =>
                      CheckboxListTile(
                          value: selectedList[index].isSelected,
                          activeColor: Colors.grey[600],
                          title: Row(
                            children: [
                              IconCustom(selectedList[index].name),
                              SizedBox(width: 10,),
                              TextFrame(comment: selectedList[index].name),
                            ],
                          ),
                          subtitle: GetBuilder<Controller>(
                              init: Controller(),
                              builder: (Seoul) {
                                try {
                                  datas.retriveLineU(
                                      LineList, selectedList[index].name);
                                  var linelist = datas.numberU;
                                  var arrival = Seoul.arrival.where((element) =>
                                  element.subwayId == linelist)
                                      .toList();
                                  var updnLine1 = ['상행', '내선'],
                                      updnLine2 = ['하행', '외선'];
                                  var updn1First = arrival
                                      .where((element) =>
                                      updnLine1.contains(element.updnLine))
                                      .map((e) => '${e.trainLineNm}')
                                      .first;
                                  var updn2First = arrival
                                      .where((element) =>
                                      updnLine2.contains(element.updnLine))
                                      .map((e) => '${e.trainLineNm}')
                                      .first;
                                  return Text(linelist.isNotEmpty
                                      ? '${updn1First.split(
                                      "-")[1]}  -  ${updn2First.split("-")[1]}'
                                      : '',
                                    style: TextStyle(
                                      fontSize: appHeight * 0.0115,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),);
                                } catch (e) {
                                  return SizedBox.shrink();
                                }
                              }),
                          onChanged: (val) {
                            if (val != null) {
                              selectedList = List.from(selectedList.map((e) {
                                if (e.name == selectedList[index].name) {
                                  print(selectedList[index].name);
                                  box.write('row1',
                                      selectedList[index].name); // Line1,Line2
                                  return e.copyWith(isSelected: !e.isSelected);
                                } else {
                                  return e;
                                }
                              })
                              );
                            }
                            setState(() {});
                          })),
            ),
          ),
        ],
      ),
    );
  }

  Widget IconCustom(String line) =>
      Icon(Icons.square,
        color: line == 'Line1' ? const Color(0xff2a4193)
            : line == 'Line2' ? const Color(0xff027a31)
            : line == 'Line3' ? const Color(0xffd75e02)
            : line == 'Line4' ? const Color(0xff028bb9)
            : line == 'Line5' ? const Color(0xff9637b6)
            : line == 'Line6' ? const Color(0xff885408)
            : line == 'Line7' ? const Color(0xff525d02)
            : line == 'Line8' ? const Color(0xfff62d37)
            : line == 'Line9' ? const Color(0xff916a2a)
            : line == '서해' ? const Color(0xff8FC31F)
            : line == '공항' ? const Color(0xff0090D2)
            : line == '경의중앙' ? const Color(0xff77C4A3)
            : line == '경춘' ? const Color(0xff0C8E72)
            : line == '수인분당' ? const Color(0xFFE8E818)
            : line == '신분당' ? const Color(0xffD4003B)
            : line == '경강선' ? const Color(0xff003DA5)
            : line == '인천1선' ? const Color(0xff7CA8D5)
            : line == '인천2선' ? const Color(0xffED8B00)
            : line == '에버라인' ? const Color(0xff6FB245)
            : line == '의정부' ? const Color(0xffFDA600)
            : line == '우이신설' ? const Color(0xffB7C452)
            : line == '김포골드' ? const Color(0xffA17800)
            : line == '신림' ? const Color(0xff6789CA)
            : Colors.black,
      );
}
