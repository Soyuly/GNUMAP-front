import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gnumap/app/utils/constants.dart';

class BusMapWebView extends StatelessWidget {
  const BusMapWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: Uri.parse(
            "http://route.hellobus.co.kr:8787/pub/routeView/gyeongsang_university_view01.html"),
        method: 'GET',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ),
    );
  }
}
