import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gnumap/app/ui/settings/widgets/developer_info_widget.dart';
import 'package:gnumap/app/ui/settings/widgets/display_setting_wiget.dart';
import 'package:gnumap/app/ui/settings/widgets/language_setting_widget.dart';
import 'package:gnumap/app/ui/settings/widgets/location_setting_widget.dart';
import 'package:gnumap/app/ui/settings/widgets/revise_setting_widget.dart';

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

  late LocationData locationData;

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
                DeveloperInfo()
              ],
            )
          ])),
    );
  }
}
