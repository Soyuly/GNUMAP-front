import 'dart:typed_data';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class ConveniencePage extends StatefulWidget {
  final int category;
  final String title;
  final String image;

  const ConveniencePage(
      {Key? key,
      required this.category,
      required this.title,
      required this.image})
      : super(key: key);

  @override
  State<ConveniencePage> createState() => _ConveniencePageState();
}

class _ConveniencePageState extends State<ConveniencePage> {
  @override
  Widget build(BuildContext context) {
    _getConvenient() async {
      var url = Uri.parse('http://203.255.3.246:5001/getInfoConvenient');
      var options = {'number': "${widget.category}"};
      var response = await http.post(url, body: options);
      // print('${response.body}');
      String jsonString = response.body;
      return jsonDecode(jsonString);
    }

    initState() {
      super.initState();
      _getConvenient();
    }

    return Align(
      alignment: Alignment.topLeft,
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemBackground,
          middle: Text('편의시설'),
        ),
        body: Container(
          child: Column(children: [
            Expanded(
              flex: 4,
              child: Stack(children: [
                Container(
                    padding: EdgeInsets.fromLTRB(155, 10, 0, 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: AssetImage(widget.image)),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ]),
            ),
            Expanded(
              flex: 20,
              child: FutureBuilder(
                  future: _getConvenient(),
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
                      List list = snapshot.data;
                      return SizedBox(
                        height: 535,
                        child: ListView.separated(
                          // padding: const EdgeInsets.all(8),
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            var li = list[index];
                            // print("${li['id']} ${li['name']}  ${li['address']}");
                            // Text("${li['name']}"),
                            // Text("${li['phone']}"),
                            // Text("${li['distance']}"),
                            return GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => _DetailPage(
                                        list: li,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(15, 15, 0, 6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 3),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                child: Image(
                                                    fit: BoxFit.cover,
                                                    width: 145,
                                                    height: 125,
                                                    image: AssetImage(
                                                        // "${li['image']}")),
                                                        'assets/convenient/cafe.jpg')),
                                              ),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    14, 0, 0, 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${li['name']}",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontFamily:
                                                              'GyeonggiMedium',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      "${li['phone']}",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontFamily:
                                                              'GyeonggiMedium'),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 60, 0, 0),
                                                      child: Text("현재위치로부터 m",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'GyeonggiMedium')),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )));
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        ),
                      );
                    }
                  }),
            )
          ]),
        ),
      ),
    );
  }
}

class _DetailPage extends StatefulWidget {
  final dynamic list;

  const _DetailPage({Key? key, required this.list}) : super(key: key);

  @override
  State<_DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<_DetailPage> {
  List info = [];
  double? lat;
  double? lng;
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData locationData;
  int? distance;
  int? time;
  var pathInfo;

  initState() {
    super.initState();
    _locateMe();
  }

  _locateMe() async {
    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }
    //
    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }
    //
    // // Track user Movements
    // await location.getLocation().then((res) {
    //   lat = res.latitude;
    //   lng = res.longitude;
    // });
    // 'curLat': '${lat}',
    // 'curLng': '${lng}',

    final url = Uri.parse('http://203.255.3.246:5001/pathConvenient');
    final response = await http.post(url, body: {
      'curLat': '35.15394690852627',
      'curLng': '128.09967466553798',
      'destLat': '${widget.list['lat']}',
      'destLng': '${widget.list['lng']}'
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    pathInfo = jsonDecode(response.body);

    return {lat, lng, pathInfo};
  }

  @override
  Widget build(BuildContext context) {
    print(widget.list);

    _locateMe();

    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemBackground,
          middle: Text('${widget.list['name']}'),
        ),
        body: FutureBuilder(
            future: _locateMe(),
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
                return Column(
                  children: [
                    Expanded(
                      flex: 15,
                      child: InAppWebView(
                        initialUrlRequest: URLRequest(
                            url: Uri.parse(
                                "http://203.255.3.246:5001/findConvenient"),
                            method: 'POST',
                            body: Uint8List.fromList(utf8.encode(
                                "curLat=35.15394690852627&curLng=128.09967466553798&destLat=${widget.list['lat']}&destLng=${widget.list['lng']}")),
                            headers: {
                              'Content-Type':
                                  'application/x-www-form-urlencoded'
                            }),
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
                              Text(pathInfo['distance'],
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
                                child: Text(pathInfo['time'],
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
