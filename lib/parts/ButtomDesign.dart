import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Lafayette.dart';
import 'LoadingBox.dart';

class BottomDesign extends StatelessWidget {

  final void Function()? onTap;

  const BottomDesign({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double appHeight = MediaQuery.of(context).size.height;  ///  896.0 IPHONE11
    double appWidth = MediaQuery.of(context).size.width;  /// 414.0 IPHONE11

    return Container(
      height: appHeight * 0.125,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          LoadingBox(),
          Lafayette(),
          AnimatedContainer(
            duration: Duration(seconds: 3),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: Container(
                  width: appWidth * 0.15,
                  height: appHeight * 0.12,
                  color: Colors.transparent,
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}
