import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:gnumap/mainpage.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';

class PathInfo extends StatefulWidget {
  final String name;
  const PathInfo({Key? key, required this.name}) : super(key: key);

  @override
  State<PathInfo> createState() => _PathInfoState();
}

class _PathInfoState extends State<PathInfo> {
  List info = [];
  WebViewController? _controller;
  double? lat;
  double? lng;
  Location location = Location();
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
      lat = res.latitude;
      lng = res.longitude;
    });

    return {lat, lng};
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          // Try removing opacity to observe the lack of a blur effect and of sliding content.
          backgroundColor: CupertinoColors.systemBackground,
          middle: Text(widget.name),
        ),
        body: FutureBuilder(
            future: _locateMe(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
              if (snapshot.hasData == false) {
                return Container(child: Text('로딩중임'));
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
                log('lat : ${lat}, lng : ${lng}');
                return Column(
                  children: [
                    Expanded(
                      flex: 15,
                      child: WebView(
                        initialUrl:
                            'http://203.255.3.246:5001/find/${lat}/${lng}/${widget.name}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webviewController) {
                          _controller = webviewController;
                        },
                        javascriptChannels: Set.from([
                          JavascriptChannel(
                              name: 'JavaScriptChannel',
                              onMessageReceived: (JavascriptMessage message) {
                                print(message.message);
                                info = message.message.split(",");
                                log(info[0]);
                              })
                        ]),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.refresh,
                                size: 35.0,
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            super.widget));
                                print('search button is clicked');
                              }),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text('소요거리',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(0, 122, 255, 1),
                                        fontFamily: 'AppleSDGothicNeo',
                                        fontWeight: FontWeight.bold)),
                              ),
                              Text('11s',
                                  style: TextStyle(
                                      fontSize: 19,
                                      color: Color.fromRGBO(0, 16, 72, 0.6),
                                      fontFamily: 'AppleSDGothicNeo')),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text('소요거리',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(0, 122, 255, 1),
                                        fontFamily: 'AppleSDGothicNeo',
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                child: Text('30분',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(0, 16, 72, 0.6),
                                        fontFamily: 'AppleSDGothicNeo')),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }));
  }
}
