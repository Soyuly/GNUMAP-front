import 'dart:io';
import 'dart:async';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gnumap/app/ui/gnumap/widgets/ad_banner_widget.dart';
import 'package:gnumap/app/ui/gnumap/widgets/gnumap_webview_widget.dart';
import 'package:gnumap/app/utils/helper/ad_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:location/location.dart';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:like_button/like_button.dart';

class GnuMap extends StatelessWidget {
  const GnuMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
            backgroundColor: CupertinoColors.systemBackground,
            middle:
                Text('GNU MAP', style: Theme.of(context).textTheme.headline5)),
        body: Column(children: [
          GnuMapWebView(),
          AdBanner(),
        ]));
  }
}
