import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSetting extends StatelessWidget {
  const LanguageSetting({Key? key}) : super(key: key);

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
              'lang_setting'.tr,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
            child: Text('lang_description'.tr,
                style: Theme.of(context).textTheme.bodyText2),
          ),
          Container(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl(
                children: {
                  0: Text('한국어'),
                  1: Text('English'),
                },
                groupValue: Get.locale == Locale('en', 'US') ? 1 : 0,
                onValueChanged: (int? newValue) {
                  if (Get.locale == Locale('en', 'US')) {
                    Get.updateLocale(const Locale('ko', 'KR'));
                  } else {
                    Get.updateLocale(const Locale('en', 'US'));
                  }
                }),
          ),
        ],
      ),
    );
  }
}
