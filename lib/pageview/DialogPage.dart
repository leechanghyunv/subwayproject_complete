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

  final String GetLine;

  const DialogPage({Key? key, required this.GetLine}) : super(key: key);

  @override
  State<DialogPage> createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {

  final Distance _distance = Distance();
  final geolocator = Get.put(GetLocation());
  final WeatherC = Get.put(WeatherController());
  final Datas = Get.put(Retrieve());
  final Seoul = Get.put(Controller());

  late String LineToId = '';
  late String DisplayLine = '';
  late List<String> Line = [];
  late List<SubwayModel> filteredSubwayInfos;
  late List<dynamic> subwayList = [];
  String selected = '';

  @override
  void initState() {
    super.initState();
    Datas.RetriveLine(LineList,widget.GetLine);
    LineToId = Datas.numberS;  // 1001
    DisplayLine = Datas.LineStringBS;
    WeatherC.CallWeather();
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
            widget.GetLine
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
                              Seoul.CallArrival(row.name);
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: DialogDesign(
                                        DesignText: 'Subway Location Map '),
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
                                            DialogDesign(DesignText: 'civil complaint Box'),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SmsContainer(),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: DialogDesignBoxC(
                                                stringNumber: widget.GetLine,
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
                                              subwayline: widget.GetLine
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
                                await Seoul.CallArrival(row.name);
                                Datas.RetriveLineS(LineList,widget.GetLine);
                                Datas.SavePositionS(SubwayInfos, row.name);
                                LineToId = Datas.numberS;  // 1001
                                DisplayLine = Datas.LineStringBS;
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: SwitchDialogA(
                                        child: GetBuilder<Controller>(
                                            init: Controller(),
                                            builder: (Seoul){
                                              var arrival = Seoul.arrival.where((element) => element.subwayId == LineToId).toList();
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
                                                  TextFrame(comment: '\n${DisplayLine} ${row.name}역'),
                                                  TextFrame(comment: updn1First.toString().toString()),
                                                  TextFrame(comment: updn1Last.toString().toString()),
                                                  TextFrame(comment: updn2First.toString().toString()),
                                                  TextFrame(comment: updn2Last.toString().toString()),
                                                ],
                                              );
                                            }),

                                        children: [

                                          WeatherC.weathericon,
                                          SizedBox(width: 5,),
                                          TextFrame(comment: '${WeatherC.des.value} ${WeatherC.temperature.value.
                                          toStringAsFixed(1)}\u2103',),
                                          Expanded(child: Text(''),),
                                          PopupMenuButton(
                                            itemBuilder: (BuildContext context) {
                                              return Datas.lineS.map((String item){
                                                return PopupMenuItem<String>(
                                                  value: item,
                                                  child: TextFrame(comment: item),
                                                );
                                              }).toList();
                                            },
                                            child: Icon(Icons.menu),
                                            onSelected: (String value) {
                                              Seoul.update();
                                              setState(() {
                                                selected = value;
                                                Datas.RetriveLineS(LineList,selected);
                                                Datas.SavePositionS(SubwayInfos, row.name);
                                                LineToId = Datas.numberS;
                                                DisplayLine = Datas.LineStringBS;
                                                print('${LineToId} ${DisplayLine}');
                                                Seoul.CallArrival(row.name);
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
                                            box.write('latA',Datas.latS);
                                            box.write('lngA',Datas.lngS);
                                            box.write('engA',Datas.engNameS);
                                            box.write('lineA',selected);
                                            box.write('line_to_NumA',LineToId);
                                            box.write('codeA',Seoul.CodeResult);
                                            box.write('convertA',Datas.LineStringBS);

                                            print('${selected} ${box.read('subwayA')}');
                                            Savemsg(
                                                row.name,Datas.engNameS
                                            );
                                          },
                                          onLongPress: (){
                                            // addlist(subwayList,row.name);

                                            box.write('subwayB',row.name);
                                            box.write('latB',Datas.latS);
                                            box.write('lngB',Datas.lngS);
                                            box.write('engB',Datas.engNameS);
                                            box.write('lineB',selected);
                                            box.write('line_to_NumB',LineToId);
                                            box.write('codeB',Seoul.CodeResult);
                                            box.write('convertB',Datas.LineStringBS);
                                            print('${selected} ${box.read('subwayB')}');
                                            Savemsg(
                                                row.name,Datas.engNameS
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

  Future<bool?> Savemsg(String name, String ename) => Fluttertoast.showToast(
      msg:'목적지 ${name}가 저장되었습니다.\n${ename}',
      gravity: ToastGravity.CENTER);

}
