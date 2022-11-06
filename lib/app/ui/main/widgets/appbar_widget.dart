import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/ui/settings/settings.dart';
import 'package:gnumap/app/ui/theme/dark_theme.dart';
import 'package:gnumap/app/ui/theme/light_theme.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('gnumap'.tr, style: Theme.of(context).textTheme.headline1),
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: IconButton(
                    padding: EdgeInsets.zero, // 패딩 설정
                    constraints: BoxConstraints(), // constraints
                    onPressed: () {
                      Get.changeTheme(
                        Get.isDarkMode ? lightThemeData : darkThemeData,
                      );
                    },
                    icon: Icon(
                        Get.isDarkMode ? Icons.brightness_2_sharp : Icons.sunny,
                        color: Theme.of(context).primaryColor)),
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
          )
        ],
      ),
    );
  }
}
