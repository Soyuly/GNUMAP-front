import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnumap/models/db.dart';
import 'package:gnumap/pathInfo.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'mainpage.dart';
import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:like_button/like_button.dart';

class SearchingPath extends StatelessWidget {
  const SearchingPath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
          middle: Text("GNU Map",
              style: TextStyle(
                  color: CupertinoColors.black, fontFamily: 'GyeonggiMedium')),
          backgroundColor: CupertinoColors.white),
      body: SlidingUpPanel(
          borderRadius: BorderRadius.circular(10.0),
          minHeight: 100,
          padding: EdgeInsets.only(left: 10, right: 10),
          header: Container(
            width: 352,
            color: Colors.white,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Center(
                    child: Column(children: [
                      Container(
                        margin: EdgeInsets.only(top: 7, bottom: 5),
                        width: 30,
                        height: 5,
                        decoration: BoxDecoration(color: Colors.grey[300]),
                      )
                    ]),
                  ),
                ),
                Row(
                  children: [
                    Text("컴퓨터과학관, 30동",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(width: 6),
                    LikeButton(onTap: onLikeButtonTapped, size: 20),
                    Favorite()
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("소요시간 20분 소요거리 4km"),
                Text("경남 진주시 진주대로 501 30동"),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          panel: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 90,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        child: Image.asset('assets/cs.jpg',
                            width: MediaQuery.of(context).size.width - 40,
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("건물 검색",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("1층: 상담실"),
                    Text("2층: 열람실"),
                    Text("3층: 308호, 312호"),
                    Text("4층: 415호, 416호, 409호"),
                    Text("4층: 415호, 416호, 409호"),
                    Text("4층: 415호, 416호, 409호"),
                    Text("4층: 415호, 416호, 409호"),
                    Text("4층: 415호, 416호, 409호"),
                    Text("4층: 415호, 416호, 409호"),
                    Text("4층: 415호, 416호, 409호"),
                    Text("4층: 415호, 416호, 409호"),
                    Text("4층: 415호, 416호, 409호"),
                    Text("4층: 415호, 416호, 409호"),
                    Text("4층: 415호, 416호, 409호"),
                    Text("4층: 415호, 416호, 409호"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '정보수정요청',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
          body: Stack(
            children: [
              Container(
                child: WebViewExample(),
              ),
              Positioned(
                  child: Container(
                margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
                child: SearchBar(),
              ))
            ],
          )),
    );
  }
}

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://www.naver.com',
    );
  }
}

// like button 클릭 시 보낼 요청
Future<bool> onLikeButtonTapped(bool isLiked) async {
  /// send your request here
  // final bool success= await sendRequest();

  /// if failed, you can do nothing
  // return success? !isLiked:isLiked;

  return !isLiked;
}

final FavoriteHelper _favoriteHelper = FavoriteHelper();

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late List _favorites = [];
  final FavoriteHelper _favoriteHelper = FavoriteHelper();

  Future _getFavorites() async {
    _favorites = await _favoriteHelper.getItems();
    print(_favorites);
    return _favorites;
  }

  bool isFavorites(String item) {
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(3, 7, 0, 0),
        child: FutureBuilder(
            future: _getFavorites(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // 즐겨찾기에 추가되어 있지 않으면
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
              // 즐겨찾기에 추가되어 있으면
              else {
                return Container(child: Text('dfdf'));
              }
            }));
  }
}
