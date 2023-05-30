import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/RetrieveData.dart';

const Color text_color = Colors.black;

class MainText extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Datas = Get.put(Retrieve());

    double appHeight = MediaQuery.of(context).size.height;
    double mainBoxHeight = appHeight * 0.58;

    return Container(
      height: appHeight * 0.58 * 0.75,
      decoration: BoxDecoration(

      ),
      child: RotatedBox(
        quarterTurns: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Datas.subwayName == 'SEOUL' ? 'SEOUL' : '${Datas.subwayName}역',
                maxLines: 1,
                style: TextStyle(
                  color: text_color,
                  fontWeight: FontWeight.bold,
                  fontSize:
                  /// IPHONE 11 기준 mainBoxHeight == 520
                  Datas.subwayName.length == 2 ? mainBoxHeight / 8/// 80
                      : Datas.subwayName.length == 3 ? mainBoxHeight / 8.5/// 80
                      : Datas.subwayName.length == 4 ? mainBoxHeight / 8.5/// 80
                      : Datas.subwayName.length == 5 ? mainBoxHeight / 8.6/// 60
                      : Datas.subwayName.length == 6 ? mainBoxHeight / 8.6/// 60
                      : Datas.subwayName.length == 7 ? mainBoxHeight / 11.4/// 45
                      : Datas.subwayName.length == 8 ? mainBoxHeight / 11.4/// 45
                      : mainBoxHeight / 14.4,
                  overflow: TextOverflow.ellipsis,
                )),
            Text(
              Datas.engName == 'SEOUL' ? ' SEOUL' : ' ${Datas.engName}',
              style: TextStyle(
                  color: text_color,
                  fontSize: Datas.engName.length < 35 ?
                  mainBoxHeight / 35 : mainBoxHeight / 40,
                  fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}