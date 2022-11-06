import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Minimap extends StatelessWidget {
  const Minimap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 15, 10),
      height: 130,
      child: GestureDetector(
          onTap: () {
            Get.toNamed('/map');
          },
          child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: Scaffold(
                backgroundColor: Colors.transparent,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('assets/minimap.png')),
                borderRadius: BorderRadius.circular(20),
              ))),
    );
  }
}
