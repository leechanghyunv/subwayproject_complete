import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/ApiController.dart';
import '../main.dart';
import '../pageview/MainPage.dart';
import 'SwitchDialogA.dart';
import 'TextFrame.dart';

class TransferIcon extends StatelessWidget {

  TransferIcon({Key? key, }) : super(key: key);

  final Seoul = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
      await Seoul.callArrival(box.read('subwayT'));
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: SwitchDialogA(
              child: GetBuilder<Controller>(
                  init: Controller(),
                  builder: (Seoul){
                    try{
                      var arrival = Seoul.arrival.where((element) => element.subwayId == box.read('line_to_NumT')).toList();
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
                            comment: '\n환승역 ${box.read('convertT')} ${box.read('subwayT')}\n',
                          ),
                          TextFrame(comment: updn1First.toString()),
                          TextFrame(comment: updn1Last.toString()),
                          TextFrame(comment: updn2First.toString()),
                          TextFrame(comment: updn2Last.toString()),
                        ],
                      );
                    }catch(e){
                      return Row(
                        children: [
                          Icon(Icons.subway),
                          TextFrame(comment: '아이콘을 꾸욱 누르시고 환승역 정보를 입력하시면\n환승역 실시간 도착정보를 확인하실 수 있어요')
                        ],);
                    }
                  }
              ),
              children: [],
            ),
          ));
    }, /// cached_rounded
        icon: Icon(Icons.cached_rounded,
          color: box.read('lineT') == 'Line1'? const Color(0xff2a4193)
              : box.read('lineT') == 'Line2'?  const Color(0xff027a31)
              : box.read('lineT') == 'Line3'?  const Color(0xffd75e02)
              : box.read('lineT') == 'Line4'?  const Color(0xff028bb9)
              : box.read('lineT') == 'Line5'?  const Color(0xff9637b6)
              : box.read('lineT') == 'Line6'?  const Color(0xff885408)
              : box.read('lineT') == 'Line7'?  const Color(0xff525d02)
              : box.read('lineT') == 'Line8'?  const Color(0xfff62d37)
              : box.read('lineT') == 'Line9'?  const Color(0xff916a2a)
              : box.read('lineT') == '서해'?    const Color(0xff8FC31F)
              : box.read('lineT') == '공항'?    const Color(0xff0090D2)
              : box.read('lineT') == '경의중앙'? const Color(0xff77C4A3)
              : box.read('lineT') == '경춘'?    const Color(0xff0C8E72)
              : box.read('lineT') == '수인분당'? const Color(0xFFE7E727)
              : box.read('lineT') == '신분당'?   const Color(0xffD4003B)
              : box.read('lineT') == '경강선'?   const Color(0xff003DA5)
              : box.read('lineT') == '인천1선'?  const Color(0xff7CA8D5)
              : box.read('lineT') == '인천2선'?  const Color(0xffED8B00)
              : box.read('lineT') == '에버라인'?  const Color(0xff6FB245)
              : box.read('lineT') == '의정부'?   const Color(0xffFDA600)
              : box.read('lineT') == '우이신설'? const Color(0xffB7C452)
              : box.read('lineT') == '김포골드'? const Color(0xffA17800)
              : box.read('lineT') == '신림'?   const Color(0xff6789CA)
              : Colors.black,));
  }

}
