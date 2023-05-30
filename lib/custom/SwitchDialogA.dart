import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../pageview/MainPage.dart';
import '../parts/QrContainer.dart';

class SwitchDialogA extends StatefulWidget {
  final Widget? child;
  final List<Widget> children;

  const SwitchDialogA(
      {Key? key, required this.child, required this.children})
      : super(key: key);

  @override
  State<SwitchDialogA> createState() => _SwitchDialogAState();
}

class _SwitchDialogAState extends State<SwitchDialogA> {

  @override
  void initState() {
    super.initState();
    // firstguide();
  }

  // void firstguide(){
  //   bool SwitchA = box.read('SwitchA') ?? true;
  //   if (SwitchA){
  //     box.write('SwitchA', false);
  //     Get.snackbar(
  //         'title',
  //         'message'
  //     );
  //   }else {
  //
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;  ///  896.0 IPHONE11

    return Container(
      height: appHeight * 0.42, /// appHeight * 0.4,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DialogDesign(
            DesignText: 'RealTime Arrival',
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              color: Colors.grey[100],
              width: double.maxFinite,
              child: widget.child,
            ),
          ),
          Row(
            children: widget.children,
          ),
        ],
      ),
    );
  }
}