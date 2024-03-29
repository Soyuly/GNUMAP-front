import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/ui/settings/settings.dart';
import 'package:gnumap/app/ui/theme/dark_theme.dart';
import 'package:gnumap/app/ui/theme/light_theme.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 10, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('gnumap'.tr, style: Theme.of(context).textTheme.headline1),
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero, // 패딩 설정
                constraints: BoxConstraints(), // constraints
                onPressed: () {
                  Get.toNamed('/bus');
                },
                icon: Icon(Icons.bus_alert,
                    size: 25, color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                padding: EdgeInsets.zero, // 패딩 설정
                constraints: BoxConstraints(), // constraints
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingPage(title: "설정")));
                },
                icon:
                    Icon(Icons.settings, color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
