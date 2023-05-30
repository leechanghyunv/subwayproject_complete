import 'package:flutter/material.dart';
import '../pageview/DialogPage.dart';
import '../parts/QrContainer.dart';
import 'TextFrame.dart';

class SwitchDialogB extends StatefulWidget {

  final String Line;
  final Widget? child;

  SwitchDialogB({Key? key, required this.Line, this.child}) : super(key: key);

  @override
  State<SwitchDialogB> createState() => _SwitchDialogBState();
}

class _SwitchDialogBState extends State<SwitchDialogB> {

  List<String> menulist = [
    'Line1', 'Line2', 'Line3', 'Line4', 'Line5', 'Line6', 'Line7', 'Line8', 'Line9', '신분당', '수인분당', '경의중앙', '우이신설', '신림', '공항',
  ];

  String Linex = '';

  @override
  void initState() {
    super.initState();
    changeline(widget.Line);
  }

  void changeline(String value) {
    setState(() {
      Linex = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      height: appHeight * 0.48,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DialogDesign(DesignText: 'Location Tracking'),
              Expanded(child: Text('')),
              Column(
                children: [
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return menulist.map((String item) {
                        return PopupMenuItem<String>(
                            value: item,
                            child: TextFrame(comment: item));
                      }).toList();
                    },
                    child: Icon(Icons.menu),
                    onSelected: (String value) {
                      print(value);
                      changeline(value);
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ///(Linex에 따라 재빌드 되도록 하려면?)
          Container(
            color: Colors.grey,
            height: appHeight * 0.2907,
            child: DialogPage(
              GetLine: Linex,
            ),
          ),
          ///
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 35,
              color: Colors.white,
              alignment: Alignment.center,
              width: double.maxFinite,
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
