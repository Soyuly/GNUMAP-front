import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviseItemTitle extends StatelessWidget {
  final String name;
  const ReviseItemTitle({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
      child: Text(
        name,
        style: Get.isDarkMode
            ? TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pretendard',
                color: Colors.white,
              )
            : TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pretendard',
                color: Color.fromRGBO(0, 0, 0, 0.69),
              ),
      ),
    );
  }
}
