import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../controller/Geolocation.dart';
import '../controller/LatlngController.dart';
import '../controller/UriController.dart';
import '../model/DataModelA.dart';
import '../model/DataModelB.dart';
import '../parts/DesignDialogC.dart';
import '../parts/Export.dart';
import '../parts/QrContainer.dart';
import '../parts/SmsContainer.dart';
import 'MainPage.dart';
import 'MapPage.dart';
import 'SecondPage.dart';

class DialogPage extends StatefulWidget {

  final String getLine;
  final List<SubwayModel> subwaylist;

  const DialogPage({Key? key, required this.getLine, required this.subwaylist}) : super(key: key);

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {

  final geolocator = Get.put(GetLocation());
  final weatherC = Get.put(WeatherController());
  final datas = Get.put(Retrieve());
  final seoul = Get.put(Controller());

  late String lineToId = '';
  late String displayLine = '';
  late List<dynamic> subwayList = [];
  String selected = '';


  @override
  void initState() {
    super.initState();
    datas.retriveLine(lineDataList,widget.getLine);
    lineToId = datas.numberS;  // 1001
    displayLine = datas.lineStringBS; // 01호선
    weatherC.callWeather();
  }

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GetBuilder<GetLocation>(
          init: GetLocation(),
          builder: (geolocator){
            if(geolocator.lat == 0.0 || geolocator.lng == 0.0){
              return Center(
                child: SizedBox(
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
            } return SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.subwaylist.length,
                  itemBuilder: (context, index){
                    var row = widget.subwaylist[index];
                    return Slidable(
                      startActionPane:  ActionPane(
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                            onPressed: ((context)  {
                              seoul.callArrival(row.name);
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: DialogDesign(
                                        designText: 'Subway Location Map '),
                                    content: Container(
                                      width: double.maxFinite,
                                      height: appHeight * 0.6,/// 330
                                      child: MapSample(
                                        subwaylat: row.lat,
                                        subwaylng: row.lng,),
                                    ),
                                    actions: [
                                    ],
                                  )
                              );
                            }
                            ),
                            backgroundColor: Colors.grey.shade400,
                            foregroundColor: Colors.black,
                            icon: Icons.location_on,
                            label: 'location',
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                          motion: StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: ((context){
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Container(
                                        height: appHeight * 0.369,/// 330
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            DialogDesign(designText: 'civil complaint Box'),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SmsContainer(),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: DialogDesignBoxC(
                                                stringNumber: widget.getLine,
                                                subwayName: row.name,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        DialogButton(comment: 'Cancel',),

                                        SizedBox(
                                          child: SmsFunction(
                                              subwayline: widget.getLine
                                          ),
                                        ),
                                      ],
                                    ));
                              }
                              ),
                              backgroundColor: Colors.grey.shade400,
                              foregroundColor: Colors.black,
                              icon: Icons.messenger_outline,
                              label: 'help',
                            ),

                          ]),

                      child: AnimatedContainer(
                        duration: Duration(seconds: 3),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              await seoul.callArrival(row.name);
                              datas.retriveLineS(lineDataList,widget.getLine);
                              datas.savePositionS(subwayInfos, row.name);
                              lineToId = datas.numberS;  // 1001
                              displayLine = datas.lineStringBS;
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: SwitchDialogA(
                                      child: GetBuilder<Controller>(
                                          init: Controller(),
                                          builder: (Seoul){
                                            var arrival = Seoul.arrival.where((element) => element.subwayId == lineToId).toList();
                                            if (arrival.isEmpty) {
                                              return TextFrame(comment: '도착 정보가 없습니다.');
                                            }
                                            var updnLine1 = ['상행', '내선'], updnLine2 = ['하행', '외선'];
                                            var updn1First = arrival.where((element) => updnLine1.contains(element.updnLine)).map((e) => '\n${e.trainLineNm} ${e.arvlMsg2}').first;
                                            var updn1Last = arrival.where((element) => updnLine1.contains(element.updnLine)).map((e) => '${e.trainLineNm} ${e.arvlMsg2}\n').last;
                                            var updn2First = arrival.where((element) => updnLine2.contains(element.updnLine)).map((e) => '${e.trainLineNm} ${e.arvlMsg2}').first;
                                            var updn2Last = arrival.where((element) => updnLine2.contains(element.updnLine)).map((e) => '${e.trainLineNm} ${e.arvlMsg2}\n').last;
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextFrame(comment: '\n${displayLine} ${row.name}역'),
                                                TextFrame(comment: updn1First.toString()),
                                                TextFrame(comment: updn1Last.toString()),
                                                TextFrame(comment: updn2First.toString()),
                                                TextFrame(comment: updn2Last.toString()),
                                              ],
                                            );
                                          }),

                                      children: [
                                        weatherC.weathericon,
                                        SizedBox(width: 5,),
                                        TextFrame(comment: '${weatherC.des.value} ${weatherC.temperature.value.
                                        toStringAsFixed(1)}\u2103',),
                                        Expanded(child: Text(''),),
                                        PopupMenuButton(
                                          itemBuilder: (BuildContext context) {
                                            return datas.lineS.map((String item){
                                              return PopupMenuItem<String>(
                                                value: item,
                                                child: TextFrame(comment: item),
                                              );
                                            }).toList();
                                          },
                                          child: Icon(Icons.menu),
                                          onSelected: (String value) {
                                            print(value);
                                            seoul.update();
                                            seoul.callArrival(row.name);
                                            seoul.callCode(row.name,value);
                                            setState(() {
                                              selected = value;
                                              datas.retriveLineS(lineDataList,value);
                                              datas.savePositionS(subwayInfos, row.name);
                                              lineToId = datas.numberS;
                                              displayLine = datas.lineStringBS;
                                              print('${lineToId} ${displayLine} ${value}');
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      DialogButton(
                                        onPressed: (){
                                         // addlist(subwayList,row.name);
                                          box.write('subwayA',row.name);
                                          box.write('latA',datas.latS);
                                          box.write('lngA',datas.lngS);
                                          box.write('engA',datas.engNameS);
                                          box.write('lineA',selected.isNotEmpty ? selected : widget.getLine);
                                          box.write('line_to_NumA',lineToId);
                                          box.write('codeA',seoul.codeResult);
                                          box.write('convertA',datas.lineStringBS);
                                          savemsg('목적지 A',row.name,datas.engNameS);
                                          print('${box.read('subwayA')} ${box.read('line_to_NumA')} ${box.read('lineA')}');
                                        },
                                        onLongPress: (){
                                         // addlist(subwayList,row.name);
                                          box.write('subwayB',row.name);
                                          box.write('latB',datas.latS);
                                          box.write('lngB',datas.lngS);
                                          box.write('engB',datas.engNameS);
                                          box.write('lineB',selected.isNotEmpty ? selected : widget.getLine);
                                          box.write('line_to_NumB',lineToId);
                                          box.write('codeB',seoul.codeResult);
                                          box.write('convertB',datas.lineStringBS);
                                          savemsg('목적지 B',row.name,datas.engNameS);
                                          print('${box.read('subwayB')} ${box.read('line_to_NumB')} ${box.read('lineA')}');
                                        },
                                        comment: 'Save',
                                      ),
                                      DialogButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        comment: 'Adapt',
                                      ),
                                    ],
                                  ));
                            },
                            child: ListTile(
                              selectedColor: Colors.grey[300],
                              title: Row(
                                children: [
                                  Text('${row.name}',
                                    style: TextStyle(
                                        fontSize:appHeight * 0.015,
                                        fontWeight:FontWeight.bold,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Text('${row.km?.toStringAsFixed(0)}m',
                                style: TextStyle(
                                    fontSize:appHeight * 0.0165,
                                    fontWeight:FontWeight.bold,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  ),
            );
          }
          ),
    );
  }

  Future<bool?> savemsg(String position, String name, String ename) => Fluttertoast.showToast(
      msg:'${position} ${name}가 저장되었습니다.\n${ename}',
      gravity: ToastGravity.CENTER);


  // void addlist (List<dynamic> list,String name){
  //   if(list.length <= 5){
  //     list.add(name);
  //     box.write('List', list);
  //   } else {
  //     list.removeAt(0);
  //     box.write('List', list);
  //   }
  // }

}
