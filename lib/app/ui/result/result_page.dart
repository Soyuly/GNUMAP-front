import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gnumap/app/ui/result/widgets/building_items_list_widget.dart';
import 'package:gnumap/app/ui/result/widgets/introduce_text_widget.dart';

import 'widgets/building_items_widget.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: Get.isDarkMode
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent, //appBar 투명색
        elevation: 0.0, //appBar 그림자 농도 설정 (값 0으로 제거)
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            CupertinoIcons.chevron_back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(23, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntroduceText(),
            SizedBox(
              height: 50,
            ),
            BuildingItemsList()
          ],
        ),
      ),
    );
  }
}
