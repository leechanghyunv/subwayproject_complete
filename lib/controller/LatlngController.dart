import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../model/DataModelA.dart';
import 'Geolocation.dart';

class LatLongController extends GetxController {

  late List<SubwayModel> filteredSubwayInfos;
  final Distance _distance = Distance();

  final geolocator = Get.put(GetLocation());

  Future<void> latlong(String line) async {
    for (var i = 0; i < subwayInfos.length; i++) {
      final km = _distance.as(
          LengthUnit.Meter,
          LatLng(geolocator.lat, geolocator.lng),
          LatLng(subwayInfos[i].lat, subwayInfos[i].lng));
      subwayInfos[i] = subwayInfos[i].setKm(km);
    }
    subwayInfos.sort((a, b) => a.km!.compareTo(b.km!));
    filteredSubwayInfos =
        subwayInfos.where((element) => element.line.contains(
            line ///
        )).toList();
  }


}