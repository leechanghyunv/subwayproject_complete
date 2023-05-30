import 'package:flutter/material.dart';
import '../parts/DesignTextB.dart';
import '../parts/Export.dart';
import 'IntroPage.dart';
import 'LinePickerA.dart';
import 'LinePickerB.dart';
import 'LoadingPage.dart';
import 'SecondPage.dart';
import 'Layout.dart';

final box = GetStorage();
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  TextEditingController controllerName = TextEditingController();
  late List<dynamic> subwayList = [];
  late bool ConvertDirection = false;
  late Future<String> _futureData;
  late String stringNumber = 'Line2';
  late String stringNumberT = 'Line2';
  late String subwayname = 'SEOUL';
  late String subwaynameT = '서울';
  late String rowname = '';
  late String LineToId = '';
  late String LineToIdT = '';

  @override
  void initState() {
    super.initState();
    _futureData = _fetchData();
    DustData.CallDust().then((value) => stringNumber = DustData.BarLevel.value);
    WeatherC.CallWeather();
  }

  final Seoul = Get.put(Controller());
  final Datas = Get.put(Retrieve());
  final DustData = Get.put(InitialController());
  final WeatherC = Get.put(WeatherController());
  final Calc = Get.put(CalculateTime());

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;  ///  896.0 IPHONE11
    double appWidth = MediaQuery.of(context).size.width;  /// 414.0 IPHONE11
    double appRatio = MediaQuery.of(context).size.aspectRatio;
    double mainBoxHeight = appHeight * 0.58;  /// 520   ~ 519.68
    bool isFirstBuild = box.read('isFirstBuild') ?? true;
    if (isFirstBuild){
      return FutureBuilder(
          future: _futureData,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingPage();
            } else {
              return LayoutPage(
                body: Center(
                  child: Column(
                    children: <Widget>[
                      TopDesign(),
                      Container(
                        height: appHeight * 0.60,
                        width: appWidth * 0.915,
                        child: Column(
                          children: <Widget>[
                            const DottedLine(
                                dashLength: 15, dashGapLength: 6, lineThickness: 7
                            ),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ColorBar(
                                    stringNumber: stringNumber,
                                  ),
                                  SizedBox(
                                    width: mainBoxHeight / 50,
                                  ),
                                  DropdownCustom(
                                    value: stringNumber,
                                    onChanged: (value){
                                      setState(() => stringNumber = value);
                                    },
                                  ),
                                  SizedBox(
                                    width: appRatio >= 0.5 ? mainBoxHeight / 6 : mainBoxHeight / 15,
                                  ),
                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: mainBoxHeight / 20,
                                      ),
                                      IconCustom(
                                        onTap: (){
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                content: Container(
                                                  color: Colors.white,
                                                  height: appHeight * 0.3907, /// 0.3907
                                                  child: TextFormA(
                                                    itemSubmitted: (value1){
                                                      setState(() {
                                                        subwayname = value1;
                                                        Datas.SavePosition(SubwayInfos, subwayname);
                                                      });
                                                      OpenDialog(subwayname);
                                                    },
                                                    onSubmitted: (value2) {
                                                      setState(() {
                                                        controllerName.text = value2;
                                                        box.write('Name', controllerName.text);
                                                      });
                                                    },
                                                    stringNumber: stringNumber,
                                                    subwayName: subwayname,
                                                    passenger: controllerName.text,
                                                  ),
                                                ),
                                                actions: [
                                                  DialogButton(
                                                    onPressed: (){
                                                      if(subwayname != 'SEOUL'){
                                                        addlist(subwayList,subwayname);
                                                        box.write('subwayA',subwayname);
                                                        box.write('latA',Datas.lat1);
                                                        box.write('lngA',Datas.lng1);
                                                        box.write('engA',Datas.engName);
                                                        box.write('lineA',stringNumber);
                                                        box.write('line_to_NumA',LineToId);
                                                        box.write('codeA',Seoul.CodeResult);
                                                        box.write('convertA',Datas.LineStringB);
                                                        box.write(subwayname,stringNumber);
                                                        Savemsg('목적지 A',subwayname,Datas.engName);
                                                      }else if(subwayname == 'SEOUL'){
                                                        Showmsg();
                                                      }
                                                    },
                                                    onLongPress: (){
                                                      if(subwayname != 'SEOUL'){
                                                        addlist(subwayList,subwayname);
                                                        box.write('subwayB',subwayname);
                                                        box.write('latB',Datas.lat1);
                                                        box.write('lngB',Datas.lng1);
                                                        box.write('engB',Datas.engName);
                                                        box.write('lineB',stringNumber);
                                                        box.write('line_to_NumB',LineToId);
                                                        box.write('codeB',Seoul.CodeResult);
                                                        box.write('convertB',Datas.LineStringB);
                                                        box.write(subwayname,stringNumber);
                                                        Savemsg('목적지 B',subwayname,Datas.engName);
                                                      }else if(subwayname == 'SEOUL'){
                                                        Showmsg();
                                                      }
                                                    },
                                                    comment: 'Save',),
                                                  DialogButton(
                                                    onPressed: (){
                                                      Navigator.pop(context);
                                                    },
                                                    comment: 'Adapt',),
                                                ],
                                              ));
                                        },
                                        onLongPress: (){
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                content: Container(
                                                  color: Colors.white,
                                                  height: appHeight * 0.45,
                                                  child: TextFormB(
                                                    itemSubmittedA: (value1) {
                                                      setState(() {
                                                        subwayname = value1;
                                                        Datas.SavePosition(SubwayInfos, subwayname);
                                                      });
                                                      OpenDialog(subwayname);
                                                    },
                                                    itemSubmittedB: (value11) {
                                                      setState(() {
                                                        subwaynameT = value11;
                                                        Datas.SavePositionT(SubwayInfos, subwaynameT);
                                                        box.write('subwayT', subwaynameT);
                                                        box.write('lineT', stringNumberT);
                                                      });
                                                      SecondDialog(subwaynameT);
                                                    },
                                                    onSubmitted: (value2) {
                                                      setState(() {
                                                        controllerName.text = value2;
                                                        box.write('Name', controllerName.text);
                                                      });
                                                    },
                                                    LineNumT: stringNumberT,
                                                  ),
                                                ),
                                                actions: [
                                                  DialogButton(
                                                    onPressed: (){
                                                      if(subwayname != 'SEOUL'){
                                                        addlist(subwayList,subwayname);
                                                        box.write('subwayA',subwayname);
                                                        box.write('latA',Datas.lat1);
                                                        box.write('lngA',Datas.lng1);
                                                        box.write('engA',Datas.engName);
                                                        box.write('lineA',stringNumber);
                                                        box.write('line_to_NumA',LineToId);
                                                        box.write('codeA',Seoul.CodeResult);
                                                        box.write('convertA',Datas.LineStringB);
                                                        box.write(subwayname,stringNumber);
                                                        Savemsg('목적지 A',subwayname,Datas.engName);
                                                      }else if(subwayname == 'SEOUL'){
                                                        Showmsg();
                                                      }
                                                    },
                                                    onLongPress: (){
                                                      if(subwayname != 'SEOUL'){
                                                        addlist(subwayList,subwayname);
                                                        box.write('subwayB',subwayname);
                                                        box.write('latB',Datas.lat1);
                                                        box.write('lngB',Datas.lng1);
                                                        box.write('engB',Datas.engName);
                                                        box.write('lineB',stringNumber);
                                                        box.write('line_to_NumB',LineToId);
                                                        box.write('codeB',Seoul.CodeResult);
                                                        box.write('convertB',Datas.LineStringB);
                                                        box.write(subwayname,stringNumber);
                                                        Savemsg('목적지 B',subwayname,Datas.engName);
                                                      }else if(subwayname == 'SEOUL'){
                                                        Showmsg();
                                                      }
                                                    },
                                                    comment: 'Save',),
                                                  DialogButton(
                                                    onPressed: (){
                                                      Navigator.pop(context);
                                                    },
                                                    comment: 'Adapt',),
                                                ],
                                              ));
                                        },
                                      ),

                                      SizedBox(height: mainBoxHeight / 20,),
                                      TextContainerA(StringNumber: stringNumber),
                                      UpandDown(
                                        color1: ConvertDirection == true ? Colors.grey[100] : Colors.grey[300],
                                        onTap1: () async {
                                          setState(() {
                                            ConvertDirection = false;
                                          });
                                        },
                                        color2: ConvertDirection == true ?  Colors.grey[100] : Colors.grey[300],
                                        onTap2: () async {
                                          setState(() {
                                            ConvertDirection = true;
                                          });
                                        },
                                      ),
                                      TextContainerB(),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                ToggleController(
                                  onToggle: (index) async {
                                    if(index == 0){
                                      if(box.read('subwayA') != null)
                                      {
                                        await Seoul.CallArrival(box.read('subwayB'));
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content:  SwitchDialogA(
                                                child: GetBuilder<Controller>(
                                                    init: Controller(),
                                                    builder: (Seoul){
                                                      try{
                                                        var arrival = Seoul.arrival.where((element) => element.subwayId == box.read('line_to_NumB')).toList();
                                                        if (arrival.isEmpty) {
                                                          return const TextFrame(comment: '도착 정보가 없습니다.');
                                                        }
                                                        var updnLine1 = ['상행', '내선'], updnLine2 = ['하행', '외선'];
                                                        var updn1First = arrival.where((element) => updnLine1.contains(element.updnLine)).map((e) => '${e.trainLineNm} ${e.arvlMsg2}').first;
                                                        var updn1Last = arrival.where((element) => updnLine1.contains(element.updnLine)).map((e) => '${e.trainLineNm} ${e.arvlMsg2}\n').last;
                                                        var updn2First = arrival.where((element) => updnLine2.contains(element.updnLine)).map((e) => '${e.trainLineNm} ${e.arvlMsg2}').first;
                                                        var updn2Last = arrival.where((element) => updnLine2.contains(element.updnLine)).map((e) => '${e.trainLineNm} ${e.arvlMsg2}\n').last;
                                                        return Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            TextFrame(
                                                              comment: '\n${box.read('convertB')} ${box.read('subwayB')}역 -> ${box.read('subwayA')}역\n',
                                                            ),
                                                            TextFrame(comment: updn1First.toString().toString()),
                                                            TextFrame(comment: updn1Last.toString().toString()),
                                                            TextFrame(comment: updn2First.toString().toString()),
                                                            TextFrame(comment: updn2Last.toString().toString()),
                                                          ],
                                                        );
                                                      }catch(e){
                                                        return SizedBox.shrink();
                                                      }
                                                    }
                                                ),
                                                children: [
                                                  WeatherC.weathericon,
                                                  SizedBox(width: 5,),
                                                  TextFrame(comment: '${WeatherC.des.value} ${WeatherC.temperature.value.
                                                  toStringAsFixed(1)}\u2103',),
                                                  Expanded(child: Text('')),
                                                  TransferIcon(),
                                                ],
                                              ),
                                              actions: [
                                                DialogButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  },
                                                  comment: 'Cancel',
                                                ),
                                                DialogButton(
                                                  onPressed: ()  {
                                                    var a = box.read('lngA').toString();
                                                    var b = box.read('latA').toString();
                                                    var c = box.read('lngB').toString();
                                                    var d = box.read('latB').toString();
                                                    Calc.CallTimeA(a, b, c, d,
                                                        box.read('subwayB'), box.read('subwayA')).
                                                    then((value) => Calc.CallTimeB(a,b, c, b,
                                                        box.read('subwayB'), box.read('subwayA')));
                                                    print('출발지 : ${box.read('subwayA')} ${b}  |  ${a}');
                                                    print('종착지 : ${box.read('subwayB')} ${d}  |  ${c}');
                                                    setState(() {
                                                      Fluttertoast.showToast(
                                                          msg:'목적지 ${box.read('subwayA') ?? 'SEOUL'}로 출발합니다.',
                                                          gravity: ToastGravity.CENTER)
                                                          .then((value) => Datas.subwayName = box.read('subwayA'))
                                                          .then((value) => Datas.engName = box.read('engA'))
                                                          .then((value) => stringNumber = box.read('lineA'))
                                                          .then((value) =>Datas.lat1 = box.read('latA'))
                                                          .then((value) =>Datas.lng1 = box.read('lngA'));
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  comment: 'Adapt',
                                                ),
                                              ],
                                            ));
                                      }else{
                                        Showmsg();
                                      }
                                    }
                                    else if(index == 1){
                                      firstguide();
                                      subwayList = box.read('List') ?? [];
                                      bool _isSelected = false; ///
                                      showDialog(
                                          context: context,
                                          builder: (context)=> AlertDialog(
                                            content: SwitchDialogB(
                                              Line: stringNumber,
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: subwayList.length,
                                                  itemBuilder: (context, index){
                                                    var row = subwayList[index];
                                                    return Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: ChoiceChip(
                                                        selectedColor: Colors.grey[300],
                                                        label: TextFrame(
                                                            comment: '$row'),
                                                        labelStyle: const TextStyle(
                                                            fontWeight: FontWeight.bold,color: Colors.black),
                                                        selected: true,
                                                        onSelected: (isSelected) async {
                                                          await Seoul.CallArrival(row);
                                                          rowname = row;
                                                          Datas.SavePosition(SubwayInfos, row);
                                                          Datas.RetriveLine(LineList,box.read(row)); /// row1// Line1.Line2
                                                          LineToId = Datas.number; /// 1001, 1002
                                                          stringNumber = box.read(row);
                                                          Seoul.CallCode(row,box.read(row));
                                                          OpenDialog(rowname);
                                                          setState(() => _isSelected = isSelected);
                                                        },
                                                      ),
                                                    );
                                                  }
                                              ),
                                            ),
                                            actions: [
                                              DialogButton(
                                                onPressed: (){
                                                  box.write('subwayA',rowname);
                                                  box.write('latA',Datas.lat1);
                                                  box.write('lngA',Datas.lng1);
                                                  box.write('engA',Datas.engName);
                                                  box.write('lineA',box.read(rowname));
                                                  box.write('line_to_NumA',LineToId);
                                                  box.write('codeA',Seoul.CodeResult);
                                                  box.write('convertA',Datas.LineStringB);
                                                  Savemsg('목적지 A',rowname,Datas.engName);
                                                },
                                                onLongPress: (){
                                                  box.write('subwayB',rowname);
                                                  box.write('latB',Datas.lat1);
                                                  box.write('lngB',Datas.lng1);
                                                  box.write('engB',Datas.engName);
                                                  box.write('lineB',box.read(rowname));
                                                  box.write('line_to_NumB',LineToId);
                                                  box.write('codeB',Seoul.CodeResult);
                                                  box.write('convertB',Datas.LineStringB);
                                                  Savemsg('목적지 B',rowname,Datas.engName);
                                                },
                                                comment: 'Save',
                                              ),
                                              DialogButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                                comment: 'Check',
                                              ),
                                            ],
                                          ));
                                    }

                                    else if(index == 2){
                                      if(box.read('subwayB') != null){
                                        await Seoul.CallArrival(box.read('subwayA'));
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content:  SwitchDialogA(
                                                child: GetBuilder<Controller>(
                                                    init: Controller(),
                                                    builder: (Seoul){
                                                      try{
                                                        var arrival = Seoul.arrival.where((element) => element.subwayId == box.read('line_to_NumA')).toList();
                                                        if (arrival.isEmpty) {
                                                          return const TextFrame(comment: '도착 정보가 없습니다.');
                                                        }
                                                        var updnLine1 = ['상행', '내선'], updnLine2 = ['하행', '외선'];
                                                        var updn1First = arrival.where((element) => updnLine1.contains(element.updnLine)).map((e) => '${e.trainLineNm} ${e.arvlMsg2}').first;
                                                        var updn1Last = arrival.where((element) => updnLine1.contains(element.updnLine)).map((e) => '${e.trainLineNm} ${e.arvlMsg2}\n').last;
                                                        var updn2First = arrival.where((element) => updnLine2.contains(element.updnLine)).map((e) => '${e.trainLineNm} ${e.arvlMsg2}').first;
                                                        var updn2Last = arrival.where((element) => updnLine2.contains(element.updnLine)).map((e) => '${e.trainLineNm} ${e.arvlMsg2}\n').last;
                                                        return Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            TextFrame(
                                                              comment: '\n${box.read('convertA')} ${box.read('subwayA')}역 -> ${box.read('subwayB')}역\n',
                                                            ),
                                                            TextFrame(comment: updn1First.toString().toString()),
                                                            TextFrame(comment: updn1Last.toString().toString()),
                                                            TextFrame(comment: updn2First.toString().toString()),
                                                            TextFrame(comment: updn2Last.toString().toString()),
                                                          ],
                                                        );
                                                      }catch(e){
                                                        return SizedBox.shrink();
                                                      }
                                                    }
                                                ),
                                                children: [
                                                  WeatherC.weathericon,
                                                  SizedBox(width: 5,),
                                                  TextFrame(comment: '${WeatherC.des.value} ${WeatherC.temperature.value.
                                                  toStringAsFixed(1)}\u2103',),
                                                  Expanded(child: Text('')),
                                                  TransferIcon(),
                                                ],
                                              ),
                                              actions: [
                                                DialogButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                  },
                                                  comment: 'Cancel',
                                                ),
                                                DialogButton(
                                                  onPressed: ()  {
                                                    var a = box.read('lngA').toString();
                                                    var b = box.read('latA').toString();
                                                    var c = box.read('lngB').toString();
                                                    var d = box.read('latB').toString();
                                                    Calc.CallTimeA(a, b, c, d,
                                                        box.read('subwayB'), box.read('subwayA')).
                                                    then((value) => Calc.CallTimeB(a,b, c, b,
                                                        box.read('subwayB'), box.read('subwayA')));
                                                    print('출발지 : ${box.read('subwayA')} ${b}  |  ${a}');
                                                    print('종착지 : ${box.read('subwayB')} ${d}  |  ${c}');
                                                    setState(() {
                                                      Fluttertoast.showToast(
                                                          msg:'목적지 ${box.read('subwayB') ?? 'SEOUL'}로 출발합니다.',
                                                          gravity: ToastGravity.CENTER)
                                                          .then((value) => Datas.subwayName = box.read('subwayB'))
                                                          .then((value) => Datas.engName = box.read('engB'))
                                                          .then((value) => stringNumber = box.read('lineB'))
                                                          .then((value) =>Datas.lat1 = box.read('latB'))
                                                          .then((value) =>Datas.lng1 = box.read('lngB'));
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  comment: 'Adapt',
                                                ),
                                              ],
                                            ));
                                      }else{
                                        Showmsg();
                                      }
                                    }
                                  },

                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      BottomDesign(
                        onTap: (){
                          {
                            showModalBottomSheet(
                                context: context,
                                enableDrag: true,
                                isScrollControlled: false,
                                builder: (_){
                                  return SecondPage();
                                });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          });
    }else {
      return IntroPage();
    }
  }


  Future<void> OpenDialog(String name) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: LinePickerA(subway: name),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.
                            all(Colors.grey[300]),
                          ),
                          child: Text("Done", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                          onPressed: () {
                            setState(() {
                              Datas.RetriveLine(LineList,box.read('row1')); /// row1// Line1.Line2
                              LineToId = Datas.number; /// 1001, 1002
                              stringNumber = box.read('row1');
                            });
                            Seoul.CallCode(subwayname,box.read('row1')); // + box.read('row1')
                            Navigator.of(context).pop();
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
    );
  }
  Future<void> SecondDialog(String name) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: LinePickerB(subway: name),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.
                            all(Colors.grey[300]),
                          ),
                          child: Text("Done", style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                          onPressed: () {
                            setState(() {
                              Datas.RetriveLineT(LineList,box.read('row2'));
                              LineToIdT = Datas.numberT; /// 1001, 1002
                              stringNumberT = box.read('row2');
                              box.write('line_to_NumT',LineToIdT);
                              box.write('convertT',Datas.LineStringBT);
                            });
                            Seoul.CallCode(subwaynameT,box.read('row2')); // + box.read('row2')
                            Navigator.of(context).pop();
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
    );
  }

  Future<String> _fetchData() async {
    await Future.delayed(Duration(milliseconds: 1950));
    return "Data loaded successfully";
  }

  Future<bool?> Showmsg() => Fluttertoast.showToast(
      msg:'목적지를 입력해주세요',
      gravity: ToastGravity.CENTER);
  Future<bool?> Savemsg(String position, String name, String ename)
  => Fluttertoast.showToast(
      msg:'${position} ${name}가 저장되었습니다.\n${ename}',
      gravity: ToastGravity.CENTER);

  void firstguide(){
    bool SaveA = box.read('Slide') ?? true;
    if (SaveA){
      box.write('Slide', false);
      Get.snackbar('title', 'message',
        titleText: TextFrame(comment: '박스안에 열차역 이름을 슬라이드 해보세요'),
        messageText: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFrame(comment: '오른쪽으로 슬라이드 -> 구글지도'),
            TextFrame(comment: '왼쪽으로 슬라이드  -> 지하철문자민원'),
            TextFrame(comment: '지하철역 이름 Tab -> 실시간 도착정보확인'),
          ],
        ),
        backgroundColor: Colors.white,
        duration: Duration(seconds: 5),
        shouldIconPulse: true,
      );
    }else {
    }
  }

  void addlist (List<dynamic> list,String name){
    if(list.length <= 5){
      list.add(name);
      box.write('List', list);
    } else {
      list.removeAt(0);
      box.write('List', list);
    }
  }

}
