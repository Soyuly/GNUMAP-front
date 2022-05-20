import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'mainpage.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'dart:async';

class SearchingPath extends StatelessWidget {
  const SearchingPath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
          leading: Align(
              widthFactor: 1.0,
              child: TextButton(
                child: Text("< 메인",
                    style: TextStyle(
                        color: CupertinoColors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'GyeonggiMedium')),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
          middle: Text("GNU Map",
              style: TextStyle(
                  color: CupertinoColors.black, fontFamily: 'GyeonggiMedium')),
          backgroundColor: CupertinoColors.white),
      body: SlidingUpPanel(
          borderRadius: BorderRadius.circular(10.0),
          minHeight: 100,
          padding: EdgeInsets.only(left: 10, right: 10),
          header: Container(
            color: Colors.white,
            width: 352,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 7, bottom: 5, left: 150),
                      width: 30,
                      height: 5,
                      decoration: BoxDecoration(color: Colors.grey[300]),
                    )
                  ]),
                ),
                Text("컴퓨터과학관, 30동",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                width: double.infinity,
                height: double.infinity,
                child: NaverMapTest(),
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

class NaverMapTest extends StatefulWidget {
  @override
  _NaverMapTestState createState() => _NaverMapTestState();
}

class _NaverMapTestState extends State<NaverMapTest> {
  Completer<NaverMapController> _controller = Completer();
  MapType _mapType = MapType.Basic;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: NaverMap(
        onMapCreated: onMapCreated,
        mapType: _mapType,
      ),
    );
  }

  void onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }
}
