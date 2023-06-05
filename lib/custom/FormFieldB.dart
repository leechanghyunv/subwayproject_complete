import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/DataModelA.dart';
import '../pageview/MainPage.dart';
import '../parts/DesignDialogB.dart';
import '../parts/QrContainer.dart';
import 'InputName.dart';
import 'InputSubway.dart';

class TextFormB extends StatefulWidget {
  final void Function(SubwayModel)? onSelectedA;
  final void Function(SubwayModel)? onSelectedB;
  final Function(String) onSubmitted;
  final String lineNumT;

  const TextFormB(
      {Key? key,
        required this.onSelectedA,
        required this.onSelectedB,
        required this.onSubmitted,
        required this.lineNumT})
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
              designText: 'Boarding Psss',
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: appHeight * 0.0112,
                  ),
                  InputSubway(onSelected: widget.onSelectedA),
                  SizedBox(
                    height: appHeight * 0.0168,
                  ),
                  InputSubway(onSelected: widget.onSelectedB),
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
                    LineNumT: widget.lineNumT,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}