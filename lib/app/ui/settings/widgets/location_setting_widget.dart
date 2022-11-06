import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationSetting extends StatelessWidget {
  const LocationSetting({Key? key}) : super(key: key);

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
              'location_setting'.tr,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Text('location_description'.tr,
              style: Theme.of(context).textTheme.bodyText2),
          SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  AppSettings.openLocationSettings();
                },
                child: Text("go_to_location".tr),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlueAccent),
                    padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                    textStyle:
                        MaterialStateProperty.all(TextStyle(fontSize: 13))),
              )),
        ],
      ),
    );
  }
}
