import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:gnumap/mainpage.dart';
import 'package:location/location.dart';

class PathInfo extends StatefulWidget {
  const PathInfo({Key? key}) : super(key: key);

  @override
  State<PathInfo> createState() => _PathInfoState();
}

class _PathInfoState extends State<PathInfo> {
  WebViewController? _controller;
  double? lat;
  double? lng;
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData locationData;

  initState() {
    super.initState();
    _locateMe();
  }

  _locateMe() async {
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
      setState(() {
        lat = res.latitude;
        lng = res.longitude;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('경도${lat} 위도 ${lng}'),
        ),
        body: FutureBuilder(
            future: _fetch1(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
              if (snapshot.hasData == false) {
                return CircularProgressIndicator();
              }
              //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              }
              // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
              else {
                return WebView(
                  initialUrl: 'http://192.168.0.66:3000/find/${lat}/${lng}',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webviewController) {
                    _controller = webviewController;
                  },
                );
              }
            }));
  }

  Future<String> _fetch1() async {
    await Future.delayed(Duration(seconds: 10));
    return 'Call Data';
  }
}
