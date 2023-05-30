import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../controller/RetrieveData.dart';
import '../main.dart';
import '../pageview/MainPage.dart';
import 'ColorContainer.dart';

const Color text_color = Colors.black;

class DialogDesignBoxA extends StatelessWidget {
  String stringNumber;
  String subwayName;
  String passenger;

  DialogDesignBoxA({
    required this.stringNumber,
    required this.subwayName,
    required this.passenger,
  });

  final Datas = Get.put(Retrieve());

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;

    return Container(
      height: appHeight * 0.0672,
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          SizedBox(
            height: appHeight * 0.0672,
            width: appHeight * 0.0168,
            child: ColorContainer(
                StringNumber: stringNumber),
          ),
          SizedBox(
            width: appHeight * 0.0112,
          ),
          Container(
            height: appHeight * 0.0784,
            width: appHeight * 0.0560,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: appHeight * 0.0112,
                ),
                Text('Date',
                    style: TextStyle(
                        color: text_color,
                        fontWeight: FontWeight.bold,
                        fontSize: appHeight * 0.0168)),
                SizedBox(
                  height: appHeight * 0.0112,
                ),
                Text(DateFormat('MM-dd').format(DateTime.now()),
                    style: TextStyle(
                        color: text_color,
                        fontWeight: FontWeight.bold,
                        fontSize: appHeight * 0.0168)),
              ],
            ),
          ),
          SizedBox(
            width: appHeight * 0.0112,
          ),
          Container(
            height: appHeight * 0.0784,
            width: appHeight * 0.0784,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: appHeight * 0.0112,
                ),
                Text('Location',
                    style: TextStyle(
                        color: text_color,
                        fontWeight: FontWeight.bold,
                        fontSize: appHeight * 0.0168)),
                SizedBox(
                  height: appHeight * 0.0112,
                ),
                Text(
                    Datas.subwayName == 'SEOUL'
                        ? 'SEOUL'
                        : '${Datas.subwayName}역',
                    style: TextStyle(
                        color: text_color,
                        fontWeight: FontWeight.bold,
                        fontSize: appHeight * 0.0168),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          SizedBox(
            width: appHeight * 0.0112,
          ),
          Container(
            height: appHeight * 0.0784,
            width: appHeight * 0.1008,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: appHeight * 0.0112,
                ),
                Text('Passenger',
                    style: TextStyle(
                        color: text_color,
                        fontWeight: FontWeight.bold,
                        fontSize: appHeight * 0.0168)),
                SizedBox(
                  height: appHeight * 0.0112,
                ),
                Text(box.read('Name') ?? '',
                    style: TextStyle(
                        color: text_color,
                        fontWeight: FontWeight.bold,
                        fontSize: appHeight * 0.0168),
                    overflow: TextOverflow.ellipsis)
              ],
            ),
          ),
        ],
      ),
    );
  }
}