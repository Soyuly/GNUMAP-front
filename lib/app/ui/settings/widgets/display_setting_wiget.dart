import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/ui/theme/dark_theme.dart';
import 'package:gnumap/app/ui/theme/light_theme.dart';

class DisplaySetting extends StatelessWidget {
  const DisplaySetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
            child: Text(
              'display_setting'.tr,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
            child: Text('display_description'.tr,
                style: Theme.of(context).textTheme.bodyText2),
          ),
          SizedBox(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl(
                children: {
                  0: Text('Light'),
                  1: Text('Dark'),
                },
                groupValue: Get.isDarkMode ? 1 : 0,
                onValueChanged: (int? newValue) {
                  if (Get.isDarkMode) {
                    Get.changeTheme(lightThemeData);
                  } else {
                    Get.changeTheme(darkThemeData);
                  }
                }),
          ),
        ],
      ),
    );
  }
}
