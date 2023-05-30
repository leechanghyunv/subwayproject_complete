import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../controller/TableController.dart';
import '../main.dart';
import '../parts/Export.dart';
import 'MainPage.dart';

List<Color> kDefaultRainbowColors = [
  Colors.black,
  Colors.black,
  Colors.black,
  Colors.black,
  Colors.black,
];

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  String time =  DateFormat('HH:mm').format(DateTime.now());

  TimeOfDay startTime = TimeOfDay(hour: 1, minute: 0);
  TimeOfDay endTime = TimeOfDay(hour: 5, minute: 0);
  TimeOfDay currentTime = TimeOfDay.now();

  ScrollController _scrollControllerA = ScrollController();
  ScrollController _scrollControllerB = ScrollController();

  final seoul = Get.put(Controller());
  final tableData = Get.put(TableController());
  bool status = false;


  String textA = '';
  String textB = '';

  int? _value = 1;

  late List<dynamic> subwayList = [];

  @override
  void initState() {
    super.initState();
    callTableB();
    subwayList = box.read('List') ?? [];
  }

  Future<String> _fetch() async {
    await Future.delayed(Duration(seconds: 1));
    return 'SEOUL';
  }

  Future<void> callTableA() async {
    await seoul.callArrival(box.read('subwayA'));
    await tableData.callData1(box.read('codeA'));
    await tableData.callData2(box.read('codeA'));
    Fluttertoast.showToast(
        msg:'${box.read('subwayA')}역 열차일정',
        gravity: ToastGravity.CENTER);
    setState(() {
      textA = seoul.arrival.where((p0) => p0.subwayId == box.read('line_to_NumA')).
      where((element) => element.updnLine == '상행' || element.updnLine == '내선').
      first.trainLineNm.toString();

      textB = seoul.arrival.where((p0) => p0.subwayId == box.read('line_to_NumA')).
      where((element) => element.updnLine == '하행' || element.updnLine == '외선').
      first.trainLineNm.toString();
    });
  }

  Future<void> callTableB() async {
    await seoul.callArrival(box.read('subwayB'));
    await tableData.callData1(box.read('codeB'));
    await tableData.callData2(box.read('codeB'));

    Fluttertoast.showToast(
        msg:'${box.read('subwayB')}역 열차일정',
        gravity: ToastGravity.CENTER);
    setState(() {
      textA = seoul.arrival.where((p0) => p0.subwayId == box.read('line_to_NumB')).
      where((element) => element.updnLine == '상행' || element.updnLine == '내선').
      first.trainLineNm.toString();

      textB = seoul.arrival.where((p0) => p0.subwayId == box.read('line_to_NumB')).
      where((element) => element.updnLine == '하행' || element.updnLine == '외선').
      first.trainLineNm.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;///  896.0 IPHONE11
    double appWidth = MediaQuery.of(context).size.width;/// 414.0 IPHONE11
    return Scaffold(
      body: FutureBuilder(
        future: _fetch(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child:
              SizedBox(
                height: 20,
                width: 45,
                child: LoadingIndicator(
                  indicatorType: Indicator.lineScale,
                  colors: kDefaultRainbowColors,
                  strokeWidth: 3,
                  pathBackgroundColor: Colors.black,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(
                    fontSize:appHeight * 0.0168,
                    fontWeight:FontWeight.bold,
                    color: Colors.black),
              ),
            );
          } else {
            if (currentTime.hour >= startTime.hour && currentTime.hour < endTime.hour){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    height: appHeight * 0.8,
                    width: appWidth,
                    child: Text(
                      '오전 01시부터 05까지는 서울시로부터\n원활한 데이터 제공을 받을 수 없습니다.',
                      style: TextStyle(
                          fontSize:appHeight * 0.0168,
                          fontWeight:FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              );
            } else {
              if(box.read('subwayB') == null || box.read('subwayB') == null){
                Fluttertoast.showToast(
                    msg:'목적지를 입력해주세요',
                    gravity: ToastGravity.CENTER);
              } else {
                return GetBuilder<TableController>(
                    init: TableController(),
                    builder: (_){
                      return Container(
                        color: Colors.white,
                        height: appHeight * 0.9,
                        width: appWidth,
                        child: Row(
                          children: [
                            ///
                            Column(
                              children: [
                                Container(
                                  width: appWidth * 0.5,
                                  height: appHeight * 0.05,
                                  color: Colors.grey[300],
                                  alignment: Alignment.center,
                                  /// '${textA}'
                                  child: Text('${textA}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: appHeight * 0.0168,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),

                                Container(
                                  width: appWidth * 0.5,
                                  height: appHeight * 0.44,
                                  child: ListView.builder(
                                      controller: _scrollControllerA,
                                      itemCount: tableData.tableA.length,
                                      itemBuilder: (context, index){
                                        var row = tableData.tableA[index];
                                        return ListTile(
                                          title: Row(
                                            children: [
                                              Expanded(
                                                child: Text.rich(
                                                  TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: '${row.subwaysname} > ${row.subwayename}행 \n',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.bold,
                                                              overflow: TextOverflow.ellipsis),
                                                        ),
                                                        TextSpan(
                                                          text:'${row.express.name == 'GENERAL'
                                                              ? '${row.express.name}(일반)'
                                                              : '${row.express.name}(급행)'}',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: row.express.name == 'GENERAL'
                                                                  ? Colors.black
                                                                  : Colors.red,
                                                              fontWeight: FontWeight.bold,
                                                              overflow: TextOverflow.ellipsis),
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: Text(
                                            '${row.arrivetime}'.substring(0,5),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }),
                                ),
                                Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.grey[400],
                                      width: appWidth/2,
                                    )),
                              ],
                            ),
                            ///
                            Column(
                              children: [
                                Container(
                                  width: appWidth * 0.5,
                                  height: appHeight * 0.05,
                                  color: Colors.grey[300],
                                  alignment: Alignment.center,
                                  child: Text('${textB}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: appHeight * 0.0168,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: appWidth * 0.5,
                                  height: appHeight * 0.44,
                                  child: ListView.builder(
                                      controller: _scrollControllerB,
                                      itemCount: tableData.tableB.length,
                                      itemBuilder: (context, index){
                                        var row = tableData.tableB[index];
                                        return ListTile(
                                          title: Row(
                                            children: [
                                              Expanded(
                                                child: Text.rich(
                                                  TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: '${row.subwaysname} > ${row.subwayename}행 \n',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.bold,
                                                              overflow: TextOverflow.ellipsis),
                                                        ),
                                                        TextSpan(
                                                          text:'${row.express.name == 'GENERAL'
                                                              ? '${row.express.name}(일반)'
                                                              : '${row.express.name}(급행)'}',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: row.express.name == 'GENERAL'
                                                                  ? Colors.black
                                                                  : Colors.red,
                                                              fontWeight: FontWeight.bold,
                                                              overflow: TextOverflow.ellipsis),
                                                        ),
                                                      ]
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: Text(
                                            '${row.arrivetime}'.substring(0,5),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                      }),
                                ),

                                Expanded(
                                  child: Container(
                                    width: appWidth/2,
                                    color: Colors.grey[400],
                                    child: FlutterSwitch(
                                      activeText: "Up",
                                      inactiveText: "Down",
                                      width: 115.0,
                                      height: 45.0,
                                      valueFontSize: 15.0,
                                      toggleSize: 45.0,
                                      value: status,
                                      borderRadius: 30.0,
                                      padding: 8.0,
                                      showOnOff: true,
                                      onToggle: (val) {

                                        setState(() {
                                          if(val == false){
                                            callTableB();
                                            status = val;
                                          } else if(val == true){
                                            callTableA();
                                            status = val;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                );
              }
              return Text('');
            }
          }
        },

      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: (){
          Fluttertoast.showToast(
              msg:'막차 시간표로 이동합니다.',
              gravity: ToastGravity.CENTER);
          final double endA = _scrollControllerA.position.maxScrollExtent;
          final double endB = _scrollControllerB.position.maxScrollExtent;
          _scrollControllerA.animateTo(endA,duration: Duration(milliseconds: 800),curve: Curves.easeIn);
          _scrollControllerB.animateTo(endB,duration: Duration(milliseconds: 800),curve: Curves.easeIn);
        },
        child: Icon(Icons.arrow_downward),
        backgroundColor: Colors.grey[700],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );

  }
}


