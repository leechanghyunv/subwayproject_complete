import 'package:flutter/material.dart';
import 'package:subway_project_230525/pageview/Layout.dart';
import 'package:subway_project_230525/pageview/MainPage.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../parts/ColorContainer.dart';
import '../parts/DesignTextB.dart';
import '../parts/Export.dart';
import '../parts/Lafayette.dart';
import '../parts/LoadingBox.dart';

class IntroPage extends StatefulWidget {
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = [];
  bool convertDirection = false;

  GlobalKey colorbarkey = GlobalKey();
  GlobalKey iconkey = GlobalKey();
  GlobalKey switch1key = GlobalKey();
  GlobalKey switch2key = GlobalKey();
  GlobalKey switch3key = GlobalKey();
  GlobalKey tablekey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _showTutorialCoachMark();
  }

  void _showTutorialCoachMark() {
    initTarget();
    tutorialCoachMark = TutorialCoachMark(
      colorShadow: Colors.grey.shade500,
      targets: targets,
      onFinish: (){
        Get.to(HomePage());
      },
      textStyleSkip:
          TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    )..show(context: context);
  }

  void initTarget() {
    targets.add(
      TargetFocus(
          shape: ShapeLightFocus.RRect,
          identify: "target 0",
          keyTarget: colorbarkey,
          contents: [
            TargetContent(
                align: ContentAlign.top,
                builder: (content, controller) {
                  return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.square,
                                color: Color(0xff027a31),
                              ),
                              TextFrame(comment: '미세먼지농도 맑음'),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.square,
                                color: Color(0xff028bb9),
                              ),
                              TextFrame(comment: '미세먼지농도 매우맑음'),
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.square,
                                color: Color(0xffd75e02),
                              ),
                              TextFrame(comment: '미세먼지농도 나쁨'),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.square,
                                color: Color(0xfff62d37),
                              ),
                              TextFrame(comment: '미세먼지농도 매우나쁨'),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFrame(comment: ' +컬러바를 탭하셔서 온도,미세먼지농도를 확인해보세요'),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ));
                }),
          ]),
    );

    targets.add(
      TargetFocus(
          shape: ShapeLightFocus.RRect,
          identify: "target 0",
          keyTarget: iconkey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                builder: (content, controller) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TextFrame(comment: '아이콘을 탭하고 출발지점,목적지를 저장해보세요'),
                        TextFrame(comment: '+아이콘을 길게 누르시면 환승역도 저장할 수 있어요'),
                        SizedBox(
                          height: 10,
                        ),

                      ],
                    ),
                  );
                }),
          ]),
    );

    targets.add(
      TargetFocus(
          shape: ShapeLightFocus.RRect,
          identify: "target 0",
          keyTarget: switch1key,
          contents: [
            TargetContent(
                align: ContentAlign.top,
                builder: (content, controller) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFrame(comment: '저장했던 정거장의 실시간 열차 도착 정보를 알려줍니다.'),
                        TextFrame(comment: '이동시간 계산, 하차 알림을 제공합니다.'),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                }),
          ]),
    );

    /// /// /// ///
    targets.add(
      TargetFocus(
          shape: ShapeLightFocus.RRect,
          identify: "target 0",
          keyTarget: switch2key,
          contents: [
            TargetContent(
                align: ContentAlign.top,
                builder: (content, controller) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFrame(comment: '현재 위치로부터 가장 가까운 역을 리스팅해줍니다.'),
                        TextFrame(comment: '지금까지 저장했던 정거장을 리스팅해줍니다.\n'),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                }),
          ]),
    );

    /// /// /// ///
    targets.add(
      TargetFocus(
          shape: ShapeLightFocus.RRect,
          identify: "target 0",
          keyTarget: switch3key,
          contents: [
            TargetContent(
                align: ContentAlign.top,
                builder: (content, controller) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TextFrame(comment: '저장했던 정거장의 실시간 열차 도착 정보를 알려줍니다.'),
                        TextFrame(comment: '이동시간 계산, 하차 알림을 제공합니다.'),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                }),
          ]),
    );

    targets.add(
      TargetFocus(
          shape: ShapeLightFocus.RRect,
          identify: "target 0",
          keyTarget: tablekey,
          contents: [
            TargetContent(
                align: ContentAlign.top,
                builder: (content, controller) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TextFrame(
                            comment:
                                '빈 공간이 아니라 버튼입니다. 해당 부분을 탭해 열차 시간표를 확인해보세요'),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                }),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;

    ///  896.0 IPHONE11
    double appWidth = MediaQuery.of(context).size.width;

    /// 414.0 IPHONE11
    double appRatio = MediaQuery.of(context).size.aspectRatio;
    double mainBoxHeight = appHeight * 0.58;

    /// 520   ~ 519.68

    return LayoutPage(
      body: Center(
        child: Column(
          children: <Widget>[
            TopDesign(),
            Container(
              height: appHeight * 0.60,
              width: appWidth * 0.915,
              child: Column(
                children: <Widget>[
                  const DottedLine(
                      dashLength: 15, dashGapLength: 6, lineThickness: 7),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: mainBoxHeight / 20,
                            ),

                            /// /// coachmark1
                            SizedBox(
                              key: colorbarkey,
                              height: appHeight * 0.58 * 0.90,
                              width: appWidth * 0.08,
                              child: ColorContainer(stringNumber: 'Line2'),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: mainBoxHeight / 50,
                        ),
                        DropdownCustom(
                          value: 'Line2',
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          width: appRatio >= 0.5
                              ? mainBoxHeight / 6
                              : mainBoxHeight / 15,
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: mainBoxHeight / 20,
                            ),
                            SizedBox(
                              key: iconkey,
                              height: mainBoxHeight / 6,
                              child: Icon(
                                Icons.subway,
                                size: mainBoxHeight / 7,
                              ),
                            ),
                            SizedBox(
                              height: mainBoxHeight / 20,
                            ),
                            TextContainerA(stringNumber: 'Line2'),
                            UpandDown(
                              color1: convertDirection == true
                                  ? Colors.grey[100]
                                  : Colors.grey[300],
                              onTap1: () {},
                              color2: convertDirection == true
                                  ? Colors.grey[100]
                                  : Colors.grey[300],
                              onTap2: () {},
                            ),
                            TextContainerB(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ToggleSwitch(
                        minWidth: 40.0,
                        minHeight: 25.0,
                        fontSize: 15.0,
                        totalSwitches: 3,
                        initialLabelIndex: null,
                        doubleTapDisable: true,
                        activeBgColor: [Colors.grey.shade600],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey[200],
                        inactiveFgColor: drop_black,
                        customIcons: [
                          Icon(
                            key: switch1key,
                            Icons.keyboard_double_arrow_right,
                            color: drop_black,
                            size: 20.0,
                          ),
                          Icon(
                            key: switch2key,
                            Icons.settings,
                            size: 20.0,
                          ),
                          Icon(
                            key: switch3key,
                            Icons.keyboard_double_arrow_left,
                            color: drop_black,
                            size: 20.0,
                          ),
                        ],
                        onToggle: (val) {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: appHeight * 0.125,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  LoadingBox(),
                  Lafayette(),
                  Container(
                    key: tablekey,
                    width: appWidth * 0.15,
                    height: appHeight * 0.12,
                    color: Colors.transparent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
