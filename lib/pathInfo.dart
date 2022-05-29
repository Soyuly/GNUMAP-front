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

class likeButton extends StatelessWidget {
  // 그 전에 검색할 때, 자신의 위치가 샌프란시스코로 나옴, 누가 달아논 주석을 본 거 같은데 다시 찾으려니 안 보임..
  // 디바이스에 이미 즐겨찾기가 추가된 상태라면, 빨간색 하트를 표시하게 하고, 아니면, 회색하트를 표시하게함
  // 즐겨찾기 추가를 하면, 검색어에 해당하는 건물 데이터, 이미지 위치를 서버에서 받아온다.
  // CupertinoSearchTextField 에서 isBack에 setState안에 _getFavorites 함수 실행
  String num;
  likeButton(this.num);

  late List _favorites = [];
  final FavoriteHelper _favoriteHelper = FavoriteHelper();

  // 즐겨찾기 정보를 가져옴
  Future _getFavorites() async {
    _favorites = await _favoriteHelper.getItems();
    print(_favorites);
    return _favorites;
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    // 검색한 이름으로 건물 정보를 가져오기
    // TODO: 여기서 에러남,, 데이터를 받아와야 하는데, 출력하니 null 값으로 들어옴

    // 즐겨찾기에서 삭제(isLiked가 true 인 상태에서 클릭했을 때)
    if (isLiked) {
      _favoriteHelper.remove(this.num);
      print("removed");
    }
    // 즐겨찾기 추가(isLiked가 false 인 상태에서 클릭했을 때)
    else {
      final response = await http.get(Uri.parse(
          'http://203.255.3.246:5001/getBuildingData?building_name=$num'));
      print(response.body);

      if (response.statusCode == 200) {
        var info = jsonDecode(response.body);
        print("즐겨찾기");
        _favoriteHelper.add(info[0]['building_num'], info[0]['building_name'],
            info[0]['building_image']);
        print(info[0]['building_num']);
        print(info[0]['building_name']);
        print(info[0]['building_image']);
        print("added");
      } else {
        throw Exception('Failed to load album');
      }
    }

    return !isLiked;
  }

  // 이미 검색어가 즐겨찾기에 추가되어 있는지 확인
  bool isExist() {
    print("ddddd");
    print(this.num.runtimeType);

    for (int i = 0; i < _favorites.length; i++) {
      print(this._favorites[i]['num'].runtimeType);
      if (_favorites[i]['num'] == this.num) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(3, 7, 0, 0),
        child: FutureBuilder(
            future: _getFavorites(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // 이미 추가되어 있으면 isLiked: true로 하트 소환 아니면 isLiked: false로 하트 소환
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
                // 로딩 되기 전에는 isLiked: false 로 하트 소환
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
