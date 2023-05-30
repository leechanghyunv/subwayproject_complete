import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../pageview/MainPage.dart';
import '../parts/DesignDialogB.dart';
import '../parts/QrContainer.dart';
import 'InputName.dart';
import 'InputSubway.dart';

class TextFormB extends StatefulWidget {
  final dynamic Function(String) itemSubmittedA;
  final dynamic Function(String) itemSubmittedB;
  final Function(String) onSubmitted;
  final String LineNumT;

  const TextFormB(
      {Key? key,
        required this.itemSubmittedA,
        required this.itemSubmittedB,
        required this.onSubmitted,
        required this.LineNumT})
      : super(key: key);

  @override
  State<TextFormB> createState() => _TextFormBState();
}

class _TextFormBState extends State<TextFormB> {


  @override
  void initState() {
    super.initState();
    firstguide();
  }

  void firstguide(){
    bool SaveB = box.read('SaveB') ?? true;
    if (SaveB){
      box.write('SaveB', false);
      Get.snackbar(
          'Save 버튼 사용법',
          '\nSave를 짧게 누르면 목적지(출발지점)A 저장\nSave를 길게 누르면 목적지(도착지점)B 저장');
    }else {

    }
  }

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;///  896.0 IPHONE11

    return Form(
        child: Column(
          children: [
            DialogDesign(
              DesignText: 'Boarding Psss',
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: appHeight * 0.0112,
                  ),
                  InputSubway(itemSubmitted: widget.itemSubmittedA),
                  SizedBox(
                    height: appHeight * 0.0168,
                  ),
                  InputSubway(itemSubmitted: widget.itemSubmittedB),
                  SizedBox(
                    height: appHeight * 0.0168,
                  ),
                  InputName(
                    onSubmitted: widget.onSubmitted,
                  ),
                  SizedBox(
                    height: appHeight * 0.015,
                  ),
                  DialogDesignBoxB(
                    LineNumT: widget.LineNumT,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
