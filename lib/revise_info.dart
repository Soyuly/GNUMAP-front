import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ReviseInfo extends StatefulWidget {

  const ReviseInfo({Key? key}) : super(key: key);

  @override
  State<ReviseInfo> createState() => _ReviseInfoState();
}

class _ReviseInfoState extends State<ReviseInfo> {
  final buildingNameController = TextEditingController();
  final buildingNumController = TextEditingController();
  final buildingLocationController = TextEditingController();
  final reviseInfoController = TextEditingController();

  @override
  void dispose() {
    buildingNameController.dispose();
    buildingNumController.dispose();
    buildingLocationController.dispose();
    reviseInfoController.dispose();
    super.dispose();
  }

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
              ),
              controller: buildingNameController,
            ),
            SizedBox(height: 20),
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
              ),
              controller: buildingNumController,
            ),
            SizedBox(height: 20),
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
              ),
              controller: buildingLocationController,
            ),
            SizedBox(height: 10),
            SizedBox(
              child: Image.asset('assets/map.png'),
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
              ),
              controller: reviseInfoController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var url = Uri.parse('http://203.255.3.246:5001/getreviseInfo');
                var response = await http.post(url, body: {
                  'request_building_name': '$buildingNameController',
                  'building_num': '$buildingNumController',
                  'request_building_location': '$buildingLocationController',
                  'request_revise': '$reviseInfoController',
                });
              },
              child: Text("수정요청"),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.all(10),
                minimumSize: Size(15.0, 20.0),
              )
            ),
          ]
        )
      )
    );
  }
}

