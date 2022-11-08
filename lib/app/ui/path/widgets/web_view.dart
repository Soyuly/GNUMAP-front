import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/my_pos_controller.dart';
import 'package:gnumap/app/controller/path_info_controller.dart';
import 'package:gnumap/app/data/model/my_pos_model.dart';
import 'package:gnumap/app/utils/constants.dart';

class PathWebView extends GetView<MyPosController> {
  final String name;
  const PathWebView({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          flex: 15,
          child: GetX<MyPosController>(
            builder: (_) {
              return InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse(BASE_URL +
                        "/v1/path/${_.me.lat}/${_.me.lng}/${Get.arguments['lat']}/${Get.arguments['lng']}"),
                    method: 'GET',
                    headers: {
                      'Content-Type': 'application/x-www-form-urlencoded'
                    }),
              );
            },
          )),
    );
  }
}
