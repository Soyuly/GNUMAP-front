import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:gnumap/main.dart';
import 'package:gnumap/mainpage.dart';
import 'package:gnumap/revise_info.dart';
import 'package:location/location.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:app_settings/app_settings.dart';

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

  int? _sliding = 0;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Scaffold(
          appBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemBackground,
            middle: Text(
              '설정',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          body:
              ListView(padding: EdgeInsets.fromLTRB(25, 20, 25, 0), children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                        child: Text(
                          tr('lang_setting'),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                        child: Text(tr('lang_description'),
                            style: Theme.of(context).textTheme.bodyText2),
                      ),
                      Container(
                        width: double.infinity,
                        child: CupertinoSlidingSegmentedControl(
                            children: {
                              0: Text('한국어'),
                              1: Text('English'),
                            },
                            groupValue:
                                context.locale.toString() == 'en_US' ? 1 : 0,
                            onValueChanged: (int? newValue) {
                              setState(() {
                                _sliding = newValue;
                                if (context.locale.toString() == 'en_US') {
                                  context.setLocale(Locale('ko', 'KR'));
                                } else {
                                  context.setLocale(Locale('en', 'US'));
                                }
                              });
                            }),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Text(
                              tr('display_setting'),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Text(tr('display_description'),
                                style: Theme.of(context).textTheme.bodyText2),
                          ),
                          Container(
                            width: double.infinity,
                            child: CupertinoSlidingSegmentedControl(
                                children: {
                                  0: Text('Light'),
                                  1: Text('Dark'),
                                },
                                groupValue: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? 1
                                    : 0,
                                onValueChanged: (int? newValue) {
                                  bool isDarkModeOn =
                                      Theme.of(context).brightness ==
                                          Brightness.dark;
                                  setState(() {
                                    _sliding = newValue;
                                    if (isDarkModeOn) {
                                      EasyDynamicTheme.of(context)
                                          .changeTheme();
                                    } else {
                                      EasyDynamicTheme.of(context)
                                          .changeTheme(dark: true);
                                    }
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Text(
                              tr('location_setting'),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Text(tr('location_description'),
                              style: Theme.of(context).textTheme.bodyText2),
                          SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  AppSettings.openLocationSettings();
                                },
                                child: Text(tr("go_to_location")),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.lightBlueAccent),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.all(5)),
                                    textStyle: MaterialStateProperty.all(
                                        TextStyle(fontSize: 13))),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Text(
                              tr("revise_setting"),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Text(tr("revise_description"),
                              style: Theme.of(context).textTheme.bodyText2),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReviseInfo()));
                              },
                              child: Text(tr("go_to_revise")),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.lightBlueAccent),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(5)),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(fontSize: 13))),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Text(
                              '버전 정보',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Row(
                            children: [
                              Text('최신버전: v0.5.2   ',
                                  style: Theme.of(context).textTheme.bodyText2),
                              Text('현재버전: v0.5.2   ',
                                  style: Theme.of(context).textTheme.bodyText2),
                              Text('지도api버전: v0.1.2',
                                  style: Theme.of(context).textTheme.bodyText2),
                            ],
                          ),
                          Text('현재 그누맵이 최신버전입니다.',
                              style: Theme.of(context).textTheme.bodyText2)
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                            child: Text(
                              '제작자 정보',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          Text('경상대학교 컴퓨터과학과: 18CLASS',
                              style: Theme.of(context).textTheme.bodyText2),
                          Text('전병규: @instagram',
                              style: Theme.of(context).textTheme.bodyText2),
                          Text('양소열: @instagram',
                              style: Theme.of(context).textTheme.bodyText2),
                          Text('정윤수: @instagram',
                              style: Theme.of(context).textTheme.bodyText2),
                          Text('강동현: @instagram',
                              style: Theme.of(context).textTheme.bodyText2),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ])),
    );
  }
}

@override
Widget build(BuildContext context) {
  throw UnimplementedError();
}
