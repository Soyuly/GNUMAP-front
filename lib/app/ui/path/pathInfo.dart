import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/favorites_controller.dart';
import 'package:gnumap/app/controller/my_pos_controller.dart';
import 'package:gnumap/app/controller/path_info_controller.dart';
import 'package:gnumap/app/data/repository/my_pos_repository.dart';
import 'package:gnumap/app/routes/app_pages.dart';
import 'package:gnumap/app/ui/path/widgets/like_icon_button_widget.dart';
import 'package:gnumap/app/ui/path/widgets/time_distance_widget.dart';
import 'package:gnumap/app/ui/path/widgets/web_view.dart';
import 'package:gnumap/main.dart';
import 'package:gnumap/app/ui/main/mainpage.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';

class PathResult extends GetView<MyPosController> {
  PathResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FavoritesController());
    return Scaffold(
        appBar: CupertinoNavigationBar(
          leading: GestureDetector(
              onTap: () async {
                Get.back();
              },
              child: Icon(
                CupertinoIcons.left_chevron,
                color: CupertinoColors.destructiveRed,
              )),
          middle: Text(Get.arguments["name"].toString()),
          trailing: LikeIconButton(),
        ),
        body: Container(
          child: Column(
            children: [
              PathWebView(
                name: Get.arguments["name"].toString(),
              ),
              TimeAndDistance(),
              SizedBox(width: 20),
            ],
          ),
        ));
  }
}
