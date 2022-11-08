import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gnumap/app/utils/constants.dart';

class GnuMapWebView extends StatelessWidget {
  const GnuMapWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 11,
      child: InAppWebView(
        initialUrlRequest: URLRequest(
            url: Uri.parse(BASE_URL + "/v1/gnumap"),
            method: 'GET',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
      ),
    );
  }
}
