import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:xml2json/xml2json.dart';
import 'Notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class CalculateTime extends GetxController {

  var time1 = null;
  int timeA = 0;
  var time2 = null;
  int timeB = 0;

  String key = '8n4clVzOSNpmtywsc27O33eO8rzisc7gPFQwT7SAsj0pvUu6rlclSuW9HNQ2PQgptvsCXVAsOpiMquTrMJzslA%3D%3D';
  String body = 'http://ws.bus.go.kr/api/rest/pathinfo/getPathInfoBySubway';

  var isLoadingA = true.obs;
  var isLoadingB = true.obs;

  @override
  void onInit() {
    super.onInit();
    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  Future<void> callTimeA(String lng1, lat1, lng2, lat2,name1,name2) async {
    final url =
        '$body?ServiceKey=$key&startX=$lng1&startY=$lat1&endX=$lng2&endY=$lat2';
    try {
      isLoadingA(false);
      final response = await GetConnect().get(url);
      if (response.statusCode == 200) {
        final responseBody = response.body;
        final xml2json = Xml2Json();
        xml2json.parse(responseBody);
        final jsonString = xml2json.toParker();
        var data = jsonDecode(jsonString);
        time1 = data["ServiceResult"]["msgBody"]["itemList"][0]["time"].toString();
        timeA = int.tryParse(time1)!;
        Get.snackbar(
          '$name1 -> $name2',
          '소요 시간 $time1분',
          mainButton: TextButton(
              onPressed: () {
                Get.closeCurrentSnackbar();
              },
              child: Text('${time1}분 후 알람설정')),
          backgroundColor: Colors.white,
          icon: Icon(Icons.subway),
          shouldIconPulse: true,
          duration: Duration(seconds: 3),
        );
        Noti.scheduleNotification(
            title: "목적지에 곧 도착합니다.",
            body: "목적지인 ${name2}(으)로 이동합니다. 내리실때 안전에 유의해 주시기 바랍니다.",
            scheduledNotificationDateTime: DateTime.now().
            add(Duration(minutes: timeA-2))).then((value) =>
            Noti.scheduleNotification(
                title: "목적지에 곧 도착합니다.",
                body: "목적지인 ${name2}(으)로 이동합니다. 내리실때 안전에 유의해 주시기 바랍니다.",
                scheduledNotificationDateTime: DateTime.now().
                add(Duration(minutes: timeA-2))));
      } else {
        print('Error occured1');
        isLoadingA(true);
      }
    } catch (e) {
      print('error1');
      isLoadingA(false);
    }
  }

  Future<void> callTimeB(String lng1, lat1, lng2, lat2, name1, name2) async {
    final url =
        '$body?ServiceKey=$key&startX=$lng1&startY=$lat1&endX=$lng2&endY=$lat2';
    try {
      isLoadingB(false);
      final response = await GetConnect().get(url);
      if (response.statusCode == 200) {
        final responseBody = response.body;
        final xml2json = Xml2Json();
        xml2json.parse(responseBody);
        final jsonString = xml2json.toParker();
        var data = jsonDecode(jsonString);
        time2 = data["ServiceResult"]["msgBody"]["itemList"]["time"].toString();
        timeB = int.tryParse(time2)!;
        Get.snackbar(
          '$name1 -> $name2',
          '소요 시간 $time2분',
          mainButton: TextButton(
              onPressed: () {
                Get.closeCurrentSnackbar();
              },
              child: Text('${time2}분 후 알람설정')),
          backgroundColor: Colors.white,
          icon: Icon(Icons.subway),
          shouldIconPulse: true,
          duration: Duration(seconds: 3),
        );
        Noti.scheduleNotification(
            title: "목적지에 곧 도착합니다.",
            body: "목적지인 ${name2}(으)로 이동합니다. 내리실때 안전에 유의해 주시기 바랍니다.",
            scheduledNotificationDateTime: DateTime.now().
            add(Duration(minutes: timeB-2))).then((value) =>
            Noti.scheduleNotification(
                title: "목적지에 곧 도착합니다.",
                body: "목적지인 ${name2}(으)로 이동합니다. 내리실때 안전에 유의해 주시기 바랍니다.",
                scheduledNotificationDateTime: DateTime.now().
                add(Duration(minutes: timeB-2))));
      } else {
        print('Error occured1');
        isLoadingB(true);
      }
    } catch (e) {
      print('error2');
      isLoadingB(false);
      // Callstate();
    }
  }

  void Callstate (){
    if(isLoadingA == false && isLoadingB == false){
      Get.snackbar('네트워크가 원활하지 않습니다',
        '이동거리 계산 기능은 행정안전부에서 제공하는 오픈 API를 기반입니다. 따라서 행정안전부 서버상의 문제가 있을경우 데이터를 제공받지 못할 수 있습니다.',
        backgroundColor: Colors.white,
        icon: Icon(Icons.subway),
        shouldIconPulse: true,
        duration: Duration(seconds: 3),
      );
    }
  }

}