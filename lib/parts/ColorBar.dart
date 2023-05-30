import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../controller/WeatherController.dart';
import '../controller/CalculateDuration.dart';
import '../controller/GoogleController.dart';
import '../controller/InitController.dart';
import 'package:flutter/material.dart';
import '../custom/QuestionBox.dart';
import '../custom/QuestionTileBox.dart';
import '../custom/SubmitButton.dart';
import '../custom/TextFrame.dart';
import '../model/UserModel.dart';
import 'package:get/get.dart';
import 'ColorContainer.dart';
import 'QrContainer.dart';

class ColorBar extends StatefulWidget {

  final String stringNumber;

  const ColorBar({Key? key, required this.stringNumber}) : super(key: key);

  @override
  State<ColorBar> createState() => _ColorBarState();
}

class _ColorBarState extends State<ColorBar> {

  final DustData = Get.put(InitialController());
  final WeatherData = Get.put(WeatherController());
  final Calc = Get.put(CalculateTime());

  String q1 = '', q2 = '',  q3 = '', q4 = '', q5 = '', q6 = '', q7 = '';

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;
    double mainBoxHeight = appHeight * 0.58;

    return Column(
      children: [
        SizedBox(
          height: mainBoxHeight / 20,
        ),
        GestureDetector(
          onTap: () {
            Get.snackbar(
              '미세먼지 농도 ${DustData.dustLevel} ${DustData.Comment}',
              '현재온도 ${WeatherData.temperature.value.toStringAsFixed(1)}\u2103',
              backgroundColor: Colors.white,
              icon: WeatherData.weathericon,
              shouldIconPulse: true,
              duration: Duration(seconds: 5),
              mainButton: TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: SingleChildScrollView(
                                child: Container(
                                  width: double.maxFinite,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      DialogDesign(
                                        designText: '스크롤로 화면을 내려주세요',
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      QuestionTile(
                                        text: '성별을 선택해주세요',
                                        onSelected: (String, index, isSelected) {
                                          setState(() {
                                            const map = {
                                              0:"남자",
                                              1:"여자",
                                            };
                                            q1 = map[index] ?? '';
                                          });
                                        },
                                        buttons: ["남자", "여자",],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      QuestionTile(
                                        text: '나이대를 선택해주세요',
                                        onSelected: (String, index, isSelected) {
                                          setState(() {
                                            const map = {
                                              0:"20~25세",
                                              1:"25~30세",
                                              2:"30~35세",
                                              3:"35~40세",
                                              4:"40~45세",
                                              5:"45~50세",
                                            };
                                            q2 = map[index] ?? '';
                                          });
                                        },
                                        buttons: ["20~25", "25~30", "30~35","35~40","40~45","45~50"],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      QuestionTile(
                                        text: '지하철 사용빈도를 알려주세요',
                                        onSelected: (String, index, isSelected) {
                                          setState(() {
                                            const map = {
                                              0:"주1~2회",
                                              1:"주3~4회",
                                              2:"주5회이상",
                                            };
                                            q3 = map[index] ?? '';
                                          });
                                        },
                                        buttons: ["주1~2회", "주3~4회", "주5회이상"],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      QuestionTile(
                                        text: '가장 유용하게 사용했던 기능은?',
                                        onSelected: (String, index, isSelected) {
                                          setState(() {
                                            const map = {
                                              0:"미세먼지농도,날씨확인",
                                              1:"실시간 도착정보",
                                              2:"민원기능",
                                              3:"열차시간표",
                                              4:"도착시간알람",
                                            };
                                            q4 = map[index] ?? '';
                                          });
                                        },
                                        buttons: ["미세먼지농도,날씨확인", "실시간도착정보", "문자민원","열차시간표","도착알람"],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      QuestionTile(
                                        text: '불편했던점이 있었나요?',
                                        onSelected: (String, index, isSelected) {
                                          setState(() {
                                            const map = {
                                              0:"불편한 사용방법",
                                              1:"정보 신뢰도",
                                              2:"지하철노선도없음",
                                            };
                                            q5 = map[index] ?? '';
                                          });
                                        },
                                        buttons: ["불편한 사용방법", "정보 신뢰도","지하철노선도없음"],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      QuestionBox(text: '개선되었으면 하는 점은?',
                                        onSubmitted: (val){
                                        setState(() {
                                          q6 = val;
                                        });
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      QuestionBox(text: '의견을 자유롭게 적어주세요',
                                        onSubmitted: (val){
                                        setState(() {
                                          q7 = val;
                                        });
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      ButtonWidget(
                                        text: '의견 전달하기',
                                        onClicked: () async {
                                          final id = await GoogleSheetsData.rowcount() + 1;
                                          final time = DateFormat('y-MM-dd EEE').format(DateTime.now());
                                          final user = UserFields(
                                            id: id, gender: q1, age: q2,
                                            frequency: q3, goodthing: q4,
                                            unconfortable: q5, comment1: q6, comment2: q7,
                                            currentTime: time,
                                          );
                                          await GoogleSheetsData.insert(
                                              [user.toJson()]);
                                          Fluttertoast.showToast(
                                              msg: '의견이 전달되었습니다',
                                              gravity: ToastGravity.CENTER);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                  },
                  child: TextFrame(comment: '설문조사')),
            );
            setState(() {});
          },
          child: SizedBox(
            height: appHeight * 0.58 * 0.90,
            width: appWidth * 0.08,
            child: ColorContainer(
                stringNumber: widget.stringNumber
            ),
          ),
        ),
      ],
    );
  }
}
