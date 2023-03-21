import 'package:gnumap/app/ui/bus/widgets/bus_webview_widget.dart';
import 'package:gnumap/app/ui/gnumap/widgets/gnumap_webview_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BusMap extends StatelessWidget {
  const BusMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemBackground,
          middle:
              Text('셔틀버스 안내', style: Theme.of(context).textTheme.headline5)),
      body: BusMapWebView(),
    );
  }
}
