import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:gnumap/main.dart';
import 'package:gnumap/mainpage.dart';
import 'package:gnumap/theme_changer.dart';
import 'package:location/location.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingPage(title: 'Settings');
  }
}

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  List info = [];
  double? lat;
  double? lng;
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData locationData;

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

      return {lat, lng};
    }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Scaffold(
          appBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemBackground,
            middle: Text('설정'),
          ),
          body:
          ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('언어지원',style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'GyeonggiMedium'),),
                      Text('맞춤형 언어를 설정할 수 있습니다.',style: TextStyle(fontFamily: 'GyeonggiMedium'))
                    ],
                  ),
                ),
                Container(
                  width: 390,
                  padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('위치정보 설정', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'GyeonggiMedium'),),
                      Text('경로찾기와 현위치 서비스에 필요한 위치정보서비스 권한을 허용받습니다.',style: TextStyle(fontFamily: 'GyeonggiMedium')),
                      SizedBox(width: 200,child: ElevatedButton(
                        onPressed: () {
                          _locateMe();
                        },
                        child: Text("위치권한 설정 바로가기"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                            padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 13))
                        ),
                      )),
                    ],
                  ),
                ),
                Container(
                  width: 390,
                  padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('문의사항 보내기',style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'GyeonggiMedium'),),
                      Text('어플에 장애나, 잘못된 정보가 있을경우 개발자에게 연락을 취할 수 있습니다.',style: TextStyle(fontFamily: 'GyeonggiMedium')),
                      SizedBox(width: 200,child: ElevatedButton(
                        onPressed: () {},
                        child: Text("문의사항 보내기"),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                            padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 13))
                        ),
                      ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('버전 정보',style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'GyeonggiMedium'),),
                      Row(children: [
                        Text('최신버전: v0.5.2   ',style: TextStyle(fontFamily: 'GyeonggiMedium')),
                        Text('현재버전: v0.5.2   ',style: TextStyle(fontFamily: 'GyeonggiMedium')),
                        Text('지도api버전: v0.1.2',style: TextStyle(fontFamily: 'GyeonggiMedium')),
                      ],),
                      Text('현재 그누맵이 최신버전입니다.',style: TextStyle(fontFamily: 'GyeonggiMedium'))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('경상대학교 컴퓨터과학과: 18CLASS',style: TextStyle(fontFamily: 'GyeonggiMedium')),
                      Text('전병규: @instagram',style: TextStyle(fontFamily: 'GyeonggiMedium')),
                      Text('양소열: @instagram',style: TextStyle(fontFamily: 'GyeonggiMedium')),
                      Text('정윤수: @instagram',style: TextStyle(fontFamily: 'GyeonggiMedium')),
                      Text('강동현: @instagram',style: TextStyle(fontFamily: 'GyeonggiMedium')),
                    ],
                  ),
                ),
              ],
            ),
          ],)

      ),
    );


  }
}

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

