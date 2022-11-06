import 'dart:developer';

import 'package:gnumap/app/data/model/my_pos_model.dart';
import 'package:location/location.dart';

class MyPosClient {
  locateMe() async {
    MyPos myPos = MyPos(lat: 0.0, lng: 0.0);
    log("실행됨");
    Location location = Location();
    late bool _serviceEnabled;
    late PermissionStatus _permissionGranted;
    late LocationData locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Track user Movements
    await location.getLocation().then((res) {
      myPos = MyPos.setData(res.latitude, res.longitude);
    });
    return myPos;
  }
}
