import 'package:flutter/material.dart';

class ReviseInfo extends StatelessWidget {
  const ReviseInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 30,
              child: Text(
                "정보수정요청",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
              child: Text(
                  "건물명",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "건물명을 입력해주세요.",
              )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 16.0, 0, 0),
              child: Text(
                "건물번호",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "건물번호를 입력해주세요.",
              )
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 16.0, 0, 0),
              child: Text(
                "위치",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "주소를 입력해주세요.",
              )
            ),
            SizedBox(height: 10),
            Container(
              child: Image.asset('map.png'),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
              child: Text(
                "수정내용",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "내용을 입력해주세요.",
              )
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                print("수정요청이 완료되었습니다.");
              },
              child: Text("수정요청"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.all(20),
                minimumSize: Size(15.0, 20.0),
              )
            ),
          ]
        )
      )
    );
  }
}

