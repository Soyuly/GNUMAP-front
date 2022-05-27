import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

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

  void _clear() {
    buildingNameController.clear();
    buildingNumController.clear();
    buildingLocationController.clear();
    reviseInfoController.clear();
  }

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
        appBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemBackground,
          middle: Text('정보수정요청'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  child: Text(
                    "건물명",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AppleSDGothicNeo',
                      color: Color.fromRGBO(0, 0, 0, 0.69),
                    ),
                  )),
              TextField(
                maxLength: 15,
                decoration: InputDecoration(
                  hintText: "건물명을 입력해주세요.",
                ),
                controller: buildingNameController,
                style: TextStyle(
                  fontFamily: 'AppleSDGothicNeo',
                ),
              ),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                  child: Text(
                    "건물번호",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AppleSDGothicNeo',
                      color: Color.fromRGBO(0, 0, 0, 0.69),
                    ),
                  )),
              TextField(
                maxLength: 15,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "건물번호를 입력해주세요.",
                ),
                controller: buildingNumController,
                style: TextStyle(fontFamily: 'AppleSDGothicNeo'),
              ),
              SizedBox(height: 20),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 16.0, 0, 0),
                  child: Text(
                    "위치",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'AppleSDGothicNeo',
                      color: Color.fromRGBO(0, 0, 0, 0.69),
                    ),
                  )),
              TextField(
                maxLength: 45,
                decoration: InputDecoration(
                  hintText: "간략한 주소를 입력해주세요.",
                ),
                controller: buildingLocationController,
                style: TextStyle(
                  fontFamily: 'AppleSDGothicNeo',
                ),
              ),
              SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                  child: Text(
                    "수정내용",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'AppleSDGothicNeo',
                        color: Color.fromRGBO(0, 0, 0, 0.69)),
                  )),
              TextField(
                maxLength: 200,
                decoration: InputDecoration(
                  hintText: "내용을 입력해주세요.",
                ),
                controller: reviseInfoController,
                style: TextStyle(
                  fontFamily: 'AppleSDGothicNeo',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    if (buildingNameController.text.isEmpty || buildingNumController.text.isEmpty ||
                        buildingLocationController.text.isEmpty || reviseInfoController.text.isEmpty) {
                      _clear();

                      Fluttertoast.showToast(
                          msg: '잘못된 정보입니다. 다시 입력해주세요',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Color.fromRGBO(0, 122, 255, 0.15),
                          textColor: Color.fromRGBO(0, 16, 72, 0.68),
                          fontSize: 13);
                    } else {
                      var url =
                      Uri.parse('http://203.255.3.246:5001/getreviseInfo');

                      var response = await http.post(url, body: {
                        'request_building_name':
                        "${buildingNameController.text}",
                        'building_num': "${buildingNumController.text}",
                        'request_building_location':
                        "${buildingLocationController.text}",
                        'request_revise': "${reviseInfoController.text}",
                      }).whenComplete(() => _clear());


                      if (response.body == 'recieved') {
                        _clear();

                        Fluttertoast.showToast(
                            msg: '요청사항은 개발자 검토 후 2 ~ 3일 내에 반영됩니다.',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromRGBO(0, 122, 255, 0.15),
                            textColor: Color.fromRGBO(0, 16, 72, 0.68),
                            fontSize: 13);
                      }

                    // } catch (e) {
                    //     _clear();
                    //
                    //     Fluttertoast.showToast(
                    //         msg: '잘못된 정보입니다. 다시 입력해주세요',
                    //         toastLength: Toast.LENGTH_LONG,
                    //         gravity: ToastGravity.BOTTOM,
                    //         timeInSecForIosWeb: 1,
                    //         backgroundColor: Color.fromRGBO(0, 122, 255, 0.15),
                    //         textColor: Color.fromRGBO(0, 16, 72, 0.68),
                    //         fontSize: 13);
                    // }
                    }
                  },
                  child: Text("보내기"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.all(10),
                    minimumSize: Size(15.0, 20.0),
                  )),
            ])));
  }
}
