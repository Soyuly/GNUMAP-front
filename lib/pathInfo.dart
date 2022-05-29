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
import 'package:fluttertoast/fluttertoast.dart';

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
  List _favorites = [];
  final FavoriteHelper _favoriteHelper = FavoriteHelper();
  late bool _isFavorite;

  Future _isFavorites() async {
    _favorites = await _favoriteHelper.isEmpty('${widget.name}');
    print(_favorites);
    _isFavorite = _favorites.isEmpty;

    return _isFavorite;
  }

  Future _getFavorites() async {
    _favorites = await _favoriteHelper.getItems();
    print(_favorites);
    return _favorites;
  }

  Future _getHistories() async {
    _histories = await _historyHelper.getItems();
    print(_histories);
    return _histories;
  }

  _locateMe() async {
    print('넘어감');
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
    } on http.ClientException {
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

  @override
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
          trailing: FutureBuilder(
              future: _isFavorites(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                if (snapshot.hasData == false) {
                  return Container(child: Text('로딩중'));
                } else if (snapshot.hasError) {
                  return Container(child: Text('로딩중'));
                }
                // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                else {
                  return Material(
                      child: IconButton(
                    color: Theme.of(context).primaryColor,
                    iconSize: 25,
                    padding: EdgeInsets.zero,
                    onPressed: () async {
                      print("실행됨");
                      final FavoriteHelper _favoriteHelper = FavoriteHelper();

                      List _favitems = [];
                      _favitems =
                          await _favoriteHelper.isEmpty('${widget.name}');

                      if (!_isFavorite) {
                        await _favoriteHelper.remove('${widget.name}');
                        setState(() {
                          _getFavorites();
                          _isFavorite = !_isFavorite;
                        });
                        Fluttertoast.showToast(
                            msg: '즐겨찾기에서 제거되었습니다.',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromRGBO(0, 122, 255, 0.15),
                            textColor: Color.fromRGBO(0, 16, 72, 0.68),
                            fontSize: 13);
                      } else {
                        var client = new http.Client();
                        var url =
                            Uri.parse('http://203.255.3.246:5001/getfavitems');
                        var response = await client
                            .post(url, body: {'num': '${widget.name}'});
                        var info = jsonDecode(response.body);
                        print('즐겨찾기 response $info');
                        await _favoriteHelper.add(info['name'], info['num']);
                        setState(() {
                          _getFavorites();
                          _isFavorite = !_isFavorite;
                        });
                        Fluttertoast.showToast(
                            msg: '즐겨찾기에 추가되었습니다',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromRGBO(0, 122, 255, 0.15),
                            textColor: Color.fromRGBO(0, 16, 72, 0.68),
                            fontSize: 13);
                      }

                      setState(() {
                        _getFavorites();
                      });
                    },
                    icon: _isFavorite
                        ? Container(
                            child: Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.red,
                            ),
                          )
                        : Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                  ));
                }
              }),
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
