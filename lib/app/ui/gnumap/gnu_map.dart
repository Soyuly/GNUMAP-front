import 'package:gnumap/app/ui/gnumap/widgets/ad_banner_widget.dart';
import 'package:gnumap/app/ui/gnumap/widgets/gnumap_webview_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
