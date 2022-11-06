import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/utils/admob.dart';
import 'package:gnumap/app/utils/helper/ad_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends StatelessWidget {
  AdBanner({Key? key}) : super(key: key) {
    adManager.addAds(true, true);
  }

  final adManager = AdManager();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        height: 50,
        child: AdWidget(ad: adManager.getBannerAd()!),
      ),
    );
  }
}
