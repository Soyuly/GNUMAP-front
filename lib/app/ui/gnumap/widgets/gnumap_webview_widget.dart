import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GnuMapWebView extends StatelessWidget {
  const GnuMapWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 11,
      child: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse("http://203.255.3.246:5001/gnumap"),
            method: 'GET',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      ),
    );
  }
}
