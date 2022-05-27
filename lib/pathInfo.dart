import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gnumap/main.dart';
import 'package:gnumap/mainpage.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:gnumap/models/db.dart';
import 'package:like_button/like_button.dart';
import 'package:gnumap/main.dart';
import 'models/db.dart';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';

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

  Future _getHistories() async {
    _histories = await _historyHelper.getItems();
    print(_histories);
    return _histories;
  }

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

    var client = new http.Client();
    var response;
    try {
      var url = Uri.parse('http://203.255.3.246:5001/getInfoBuilding');
      response = await client.post(url, body: {
        'curLat': '${lat}',
        'curLng': '${lng}',
        'num': '${widget.name}'
      }).timeout(Duration(seconds: 10), onTimeout: () {
        return http.Response('Error', 408);
      });
    } on SocketException {
      if (!mounted) return;
      return WidgetsBinding.instance.addPostFrameCallback((_) async {
        showCupertinoDialog(
            context: context,
            useRootNavigator: false,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(tr('network_error_title')),
                content: Text(tr('network_error')),
                actions: [
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text("확인"),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              );
            }).then((value) => Navigator.pop(context));
      });
    } on HttpException {
      if (!mounted) return;
      return WidgetsBinding.instance.addPostFrameCallback((_) async {
        showCupertinoDialog(
            context: context,
            useRootNavigator: false,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(tr('server_error_title')),
                content: Text(tr('server_error')),
                actions: [
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text("확인"),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              );
            }).then((value) => Navigator.pop(context));
      });
    } finally {
      client.close();
    }
    try {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      String jsonData = response.body;
      var info = jsonDecode(response.body);
      distance = info['distance'];
      time = info['time'];
    } on FormatException {
      if (!mounted) return;
      return WidgetsBinding.instance.addPostFrameCallback((_) async {
        showCupertinoDialog(
            context: context,
            useRootNavigator: false,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(tr('search_error_title')),
                content: Text(tr('search_error')),
                actions: [
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text("확인"),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              );
            }).then((value) => Navigator.pop(context));
      });
    }

    if (distance == null) {
      if (!mounted) return;
      return WidgetsBinding.instance.addPostFrameCallback((_) async {
        showCupertinoDialog(
            context: context,
            useRootNavigator: false,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text('검색가능한 거리를 초과하였습니다.'),
                content: Text('경상국립대 내에서 이용해주세요'),
                actions: [
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text("확인"),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              );
            }).then((value) => Navigator.pop(context));
      });
    }

    List _items = [];
    _items = await _historyHelper.isEmpty('${widget.name}');

    if (_items.isEmpty) {
      await _historyHelper.add('${widget.name}');
      setState(() {
        _getHistories();
      });
    } else {
      _historyHelper.remove('${widget.name}');
      await _historyHelper.add('${widget.name}');
    }

    return {lat, lng, distance, time};
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          leading: GestureDetector(
              onTap: () async {
                Navigator.pop(context, true);
              },
              child: Icon(
                CupertinoIcons.left_chevron,
                color: CupertinoColors.destructiveRed,
              )),
          trailing: Material(
            child: IconButton(
              icon: likeButton(widget.name),
              padding: EdgeInsets.zero,
              onPressed: () => log('버튼눌림'),
            ),
          ),
          backgroundColor: CupertinoColors.systemBackground,
          middle: Text(
            widget.name,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: FutureBuilder(
            future: _locateMe(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
              if (snapshot.hasData == false) {
                return Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/loading.gif",
                            height: 205.0,
                            width: 200.0,
                          ),
                          Text('하모가 열심히 길을 찾고 있습니다.',
                              style: TextStyle(
                                fontSize: 24,
                                color: Color.fromRGBO(0, 122, 255, 1),
                                fontFamily: 'GangwonEduSaeeum',
                              ))
                        ],
                      )),
                );
              }
              //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/error.gif",
                          height: 205.0,
                          width: 200.0,
                        ),
                        Text('${widget.name}으로 가는 경로가 존재하지 않습니다.',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color.fromRGBO(0, 122, 255, 1),
                              fontFamily: 'GangwonEduSaeeum',
                            ))
                      ],
                    ));
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
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              Text('${distance}',
                                  style: Theme.of(context).textTheme.subtitle1),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text('소요시간',
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              Container(
                                child: Text('${time}',
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
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

Future<bool> onLikeButtonTapped(bool isLiked, String name) async {
  /// send your request here
  // final bool success= await sendRequest();

  /// if failed, you can do nothing
  // return success? !isLiked:isLiked;

  final FavoriteHelper _favoriteHelper = FavoriteHelper();

  var client = new http.Client();
  var url = Uri.parse('http://203.255.3.246:5001/getInfoBuilding');
  var response = await client.post(url, body: {'num': '$name'});
  var info = jsonDecode(response.body);

  await _favoriteHelper.add(info['name'], info['num']);
  print('버튼눌림');
  return !isLiked;
}

class likeButton extends StatelessWidget {
  String name;
  likeButton(this.name);

  late List _favorites = [];
  final FavoriteHelper _favoriteHelper = FavoriteHelper();

  Future _getFavorites() async {
    _favorites = await _favoriteHelper.getItems();
    print(_favorites);
    return _favorites;
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    late List _favorites = [];
    final FavoriteHelper _favoriteHelper = FavoriteHelper();

    var client = new http.Client();
    var url = Uri.parse('http://203.255.3.246:5001/getInfoBuilding');
    var response = await client.post(url, body: {'num': '$name'});
    var info = jsonDecode(response.body);

    print('버튼눌림');

    // 즐겨찾기 추가
    if (isLiked) {
      _favoriteHelper.remove(this.name);
      _favoriteHelper.remove(this.name);
      print("removed");
    }
    // 즐겨찾기 삭제
    else {
      _favoriteHelper.add(info['name'], info['num']);
      _favoriteHelper.add(info['name'], info['num']);
      print(info['name']);
      print(info['num']);
      print("added");
    }

    return !isLiked;
  }

  bool isExist() {
    for (int i = 0; i < _favorites.length; i++) {
      if (_favorites[i]['name'] == this.name) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    String name = this.name;
    return Container(
        margin: const EdgeInsets.fromLTRB(3, 7, 0, 0),
        child: FutureBuilder(
            future: _getFavorites(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (isExist()) {
                  return LikeButton(
                    onTap: onLikeButtonTapped,
                    size: 25,
                    isLiked: true,
                  );
                } else {
                  return LikeButton(
                    onTap: onLikeButtonTapped,
                    size: 25,
                    isLiked: false,
                  );
                }
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
              } else {
                return LikeButton(
                  onTap: onLikeButtonTapped,
                  size: 25,
                  isLiked: false,
                );
              }
              // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
            }));
  }
}
