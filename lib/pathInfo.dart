import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gnumap/main.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:gnumap/models/db.dart';
import 'package:like_button/like_button.dart';

class PathInfo extends StatefulWidget {
  final String name;
  const PathInfo({Key? key, required this.name}) : super(key: key);

  @override
  State<PathInfo> createState() => _PathInfoState();
}

class _PathInfoState extends State<PathInfo> {
  late List _histories = [];
  final HistoryHelper _historyHelper = HistoryHelper();
  List info = [];
  double? lat;
  double? lng;
  String? distance;
  String? time;
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

    var url = Uri.parse('http://203.255.3.246:5001/getInfoBuilding');
    var response = await http.post(url, body: {
      'curLat': '${lat}',
      'curLng': '${lng}',
      'num': '${widget.name}'
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    String jsonData = response.body;
    var info = jsonDecode(response.body);
    distance = info['distance'];
    time = info['time'];

    print('추가됨');
    await _historyHelper.add('${widget.name}');

    return {lat, lng, distance, time};
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          trailing: IconButton(
            icon: LikeButton(onTap: onLikeButtonTapped, size: 25),
            onPressed: () => log('버튼눌림'),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp())),
            child: Container(
              child: Icon(
                CupertinoIcons.left_chevron,
                color: CupertinoColors.destructiveRed,
              ),
            ),
          ),
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
                log('lat : ${lat}, lng : ${lng}, distance : ${distance}');
                return Column(
                  children: [
                    Expanded(
                        flex: 15,
                        child: InAppWebView(
                          initialUrlRequest: URLRequest(
                              url: Uri.parse("http://203.255.3.246:5001/find"),
                              method: 'POST',
                              body: Uint8List.fromList(utf8.encode(
                                  "lat=${lat}&lng=${lng}&num=${widget.name}")),
                              headers: {
                                'Content-Type':
                                    'application/x-www-form-urlencoded'
                              }),
                        )),
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
                              Text('${distance}',
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
                                child: Text('소요시간',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromRGBO(0, 122, 255, 1),
                                        fontFamily: 'AppleSDGothicNeo',
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                child: Text('${time}',
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

Future<bool> onLikeButtonTapped(bool isLiked) async {
  /// send your request here
  // final bool success= await sendRequest();

  /// if failed, you can do nothing
  // return success? !isLiked:isLiked;
  print('버튼눌림');
  return !isLiked;
}
