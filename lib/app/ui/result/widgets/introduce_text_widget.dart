import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/theme_controller.dart';

class IntroduceText extends StatelessWidget {
  const IntroduceText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeController _controller = Get.put(ThemeController());
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Text(
        '찾으시려는 건물을\n선택 해주세요.',
        style: Get.isDarkMode
            ? TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontFamily: 'AppleSDGothicNeo',
                fontWeight: FontWeight.bold)
            : TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontFamily: 'AppleSDGothicNeo',
                fontWeight: FontWeight.bold),
      ),
    );
  }
}
