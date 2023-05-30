import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

List<Color> kDefaultRainbowColors1 = [
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
];

class LoadingBox extends StatelessWidget {
  const LoadingBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height; ///  896.0 IPHONE11

    return SizedBox(
      height: 20,
      width: 45,
      child: LoadingIndicator(
        /// kDefaultRainbowColors1 = 흰색 : kDefaultRainbowColors = 검정색
        indicatorType: Indicator.lineScale,
        colors: kDefaultRainbowColors1,
        strokeWidth: 3,
      ),
    );
  }
}