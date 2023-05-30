import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lafayette extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;

    return  Container(
        alignment: Alignment.center,
        width: appWidth * 0.55,
        height: appHeight * 0.125,
        child: BarcodeWidget(
          data: '------LAFAYETTE.co-------',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
          color: Colors.black,
          barcode: Barcode.code128(),
        ));
  }
}