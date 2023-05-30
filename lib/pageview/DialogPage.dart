import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../controller/Geolocation.dart';
import '../controller/UriController.dart';
import '../main.dart';
import '../parts/DesignDialogC.dart';
import '../parts/Export.dart';
import '../parts/QrContainer.dart';
import '../parts/SmsContainer.dart';
import 'MainPage.dart';
import 'MapPage.dart';
import 'SecondPage.dart';

class DialogPage extends StatefulWidget {

  final String getLine;

  const DialogPage({Key? key, required this.getLine}) : super(key: key);

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {

  final Distance _distance = Distance();
  final geolocator = Get.put(GetLocation());
  final weatherC = Get.put(WeatherController());
  final datas = Get.put(Retrieve());
  final seoul = Get.put(Controller());

  late String lineToId = '';
  late String displayLine = '';
  late List<String> Line = [];
  late List<SubwayModel> filteredSubwayInfos;
  late List<dynamic> subwayList = [];
  String selected = '';

  @override
  void initState() {
    super.initState();
    datas.retriveLine(LineList,widget.getLine);
    lineToId = datas.numberS;  // 1001
    displayLine = datas.lineStringBS;
    weatherC.callWeather();
    for (var i = 0; i < SubwayInfos.length; i++) {
      final km = _distance.as(
          LengthUnit.Meter,
          LatLng(geolocator.lat, geolocator.lng),
          LatLng(SubwayInfos[i].lat, SubwayInfos[i].lng));
      SubwayInfos[i].km = km;
    }
    SubwayInfos.sort((a, b) => a.km!.compareTo(b.km!));
    filteredSubwayInfos =
        SubwayInfos.where((element) => element.line.contains(
            widget.getLine
        )).toList();
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
                  itemCount: filteredSubwayInfos.length,
                  itemBuilder: (context, index){
                    var row = filteredSubwayInfos[index];

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

                      child: ListTile(
                        selectedColor: Colors.grey[300],
                        title: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await seoul.callArrival(row.name);
                                datas.retriveLineS(LineList,widget.getLine);
                                datas.savePositionS(SubwayInfos, row.name);
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
                                                  TextFrame(comment: updn1First.toString().toString()),
                                                  TextFrame(comment: updn1Last.toString().toString()),
                                                  TextFrame(comment: updn2First.toString().toString()),
                                                  TextFrame(comment: updn2Last.toString().toString()),
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
                                              seoul.update();
                                              setState(() {
                                                selected = value;
                                                datas.retriveLineS(LineList,selected);
                                                datas.savePositionS(SubwayInfos, row.name);
                                                lineToId = datas.numberS;
                                                displayLine = datas.lineStringBS;
                                                print('${lineToId} ${displayLine}');
                                                seoul.callArrival(row.name);
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
                                            box.write('lineA',selected);
                                            box.write('line_to_NumA',lineToId);
                                            box.write('codeA',seoul.codeResult);
                                            box.write('convertA',datas.lineStringBS);

                                            print('${selected} ${box.read('subwayA')}');
                                            savemsg(
                                                row.name,datas.engNameS
                                            );
                                          },
                                          onLongPress: (){
                                            // addlist(subwayList,row.name);

                                            box.write('subwayB',row.name);
                                            box.write('latB',datas.latS);
                                            box.write('lngB',datas.lngS);
                                            box.write('engB',datas.engNameS);
                                            box.write('lineB',selected);
                                            box.write('line_to_NumB',lineToId);
                                            box.write('codeB',seoul.codeResult);
                                            box.write('convertB',datas.lineStringBS);
                                            print('${selected} ${box.read('subwayB')}');
                                            savemsg(
                                                row.name,datas.engNameS
                                            );
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
                              child: Text('${row.name}',
                                style: TextStyle(
                                    fontSize:appHeight * 0.015,
                                    fontWeight:FontWeight.bold,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis
                                ),
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

                    );
                  }
                  ),
            );
          }
          ),
    );
  }

  Future<bool?> savemsg(String name, String ename) => Fluttertoast.showToast(
      msg:'목적지 ${name}가 저장되었습니다.\n${ename}',
      gravity: ToastGravity.CENTER);

}
