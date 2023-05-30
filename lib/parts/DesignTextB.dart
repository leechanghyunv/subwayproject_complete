import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../pageview/MainPage.dart';

const Color text_color = Colors.black;

class TextContainerB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double appHeight = MediaQuery.of(context).size.height;
    double mainBoxHeight = appHeight * 0.58;

    return RotatedBox(
      quarterTurns: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DATE',
                    style: TextStyle(
                        color: text_color,
                        fontWeight: FontWeight.bold,
                        fontSize: mainBoxHeight / 25),
                  ),
                  SizedBox(
                    height: mainBoxHeight / 60,
                  ),
                  Text(
                    DateFormat('MM/dd ').format(DateTime.now()),
                    style: TextStyle(
                        color: text_color,
                        fontWeight: FontWeight.bold,
                        fontSize: mainBoxHeight / 25),
                  ),
                ],
              ),

              /// DATE
              SizedBox(
                width: mainBoxHeight / 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SEAT',
                    style: TextStyle(
                        color: text_color,
                        fontWeight: FontWeight.bold,
                        fontSize: mainBoxHeight / 25),
                  ),
                  SizedBox(
                    height: mainBoxHeight / 60,
                  ),
                  Text(
                    '13XX',
                    style: TextStyle(
                        color: text_color,
                        fontWeight: FontWeight.bold,
                        fontSize: mainBoxHeight / 25),
                  ),
                ],
              ),

              /// SEAT
              SizedBox(
                width: mainBoxHeight / 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CLASS',
                    style: TextStyle(
                        color: text_color,
                        fontWeight: FontWeight.bold,
                        fontSize: mainBoxHeight / 25),
                  ),
                  SizedBox(
                    height: mainBoxHeight / 60,
                  ),
                  Text(
                    // controllerAPI_D.Type == null? 'NOR(S)'
                    //   : controllerAPI_D.Type == '급행'? 'EXP(S)'
                    //   : controllerAPI_D.Type == 'ITX' ? 'ITX(T)' :
                    'NOR(S)',

                    style: TextStyle(
                        color: text_color,
                        fontWeight: FontWeight.bold,
                        fontSize: mainBoxHeight / 25),
                  ),
                ],
              ),

              /// CLASS
            ],
          ),
          SizedBox(
            height: mainBoxHeight / 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PASSENGER :',
                style: TextStyle(
                    color: text_color,
                    fontWeight: FontWeight.bold,
                    fontSize: mainBoxHeight / 25),
              ),
              SizedBox(
                height: mainBoxHeight / 40,
              ),
              Text(
                box.read('Name') ?? '',
                style: TextStyle(
                    color: text_color,
                    fontWeight: FontWeight.bold,
                    fontSize: mainBoxHeight / 30),
              ),
            ],
          ),

          /// PASSENGER NAME
        ],
      ),
    );
  }
}