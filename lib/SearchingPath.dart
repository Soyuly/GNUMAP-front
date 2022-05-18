import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchingPath extends StatelessWidget {
  const SearchingPath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SlidingUpPanelExample"),
      ),
      body: SlidingUpPanel(
        borderRadius: BorderRadius.circular(10.0),
        minHeight: 100,
        padding: EdgeInsets.only(left: 10, right: 10),
        collapsed: Container(
          width: MediaQuery.of(context).size.width - 40,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 7, bottom: 5),
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(color: Colors.grey[300]),
                  ),
                ],
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
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      child: Image.asset('assets/aram.jpg',
                          width: MediaQuery.of(context).size.width - 40,
                          fit: BoxFit.fitWidth),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("건물 검색",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
        body: Center(
            child: Container(
          child: Image.asset('assets/map.png',
              width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth),
        )),
      ),
    );
  }
}
