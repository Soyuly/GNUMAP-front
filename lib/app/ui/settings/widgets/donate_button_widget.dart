import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/routes/app_pages.dart';
import 'package:gnumap/app/ui/revise/revise_info.dart';
import 'package:gnumap/app/utils/admob.dart';
import 'package:gnumap/app/utils/helper/ad_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class DonateButton extends StatelessWidget {
  DonateButton({Key? key}) : super(key: key) {
    adManager.addAds(true, true);
  }

  final adManager = AdManager();

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
              "donate".tr,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Text("donate_description".tr,
              style: Theme.of(context).textTheme.bodyText2),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                adManager.showRewardedAd();
              },
              child: Text("ad".tr),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent),
                  padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                  textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 13))),
            ),
          ),
        ],
      ),
    );
  }
}
