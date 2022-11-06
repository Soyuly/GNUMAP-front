import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/ui/revise/revise_info.dart';
import 'package:gnumap/app/ui/settings/widgets/developer_info_widget.dart';
import 'package:gnumap/app/ui/settings/widgets/display_setting_wiget.dart';
import 'package:gnumap/app/ui/settings/widgets/donate_button_widget.dart';
import 'package:gnumap/app/ui/settings/widgets/language_setting_widget.dart';
import 'package:gnumap/app/ui/settings/widgets/location_setting_widget.dart';
import 'package:gnumap/app/ui/settings/widgets/revise_setting_widget.dart';
import 'package:gnumap/main.dart';

import 'package:location/location.dart';
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
                LanguageSetting(),
                DisplaySetting(),
                LocationSetting(),
                ReviseSetting(),
                DonateButton(),
                DeveloperInfo()
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
