import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gnumap/app/ui/convenients/widgets/convenient_items.dart';
import 'package:gnumap/app/ui/convenients/widgets/convenient_items_list.dart';
import 'package:gnumap/app/ui/convenients/widgets/convenient_top_banner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart' as http;
import 'package:location/location.dart';

class ConvenientPage extends StatelessWidget {
  const ConvenientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemBackground,
          middle: Text('편의시설'),
        ),
        body: Container(
          child: Column(children: [
            ConvenientTopBanner(),
            ConvenientItemsList(),
          ]),
        ),
      ),
    );
  }
}
