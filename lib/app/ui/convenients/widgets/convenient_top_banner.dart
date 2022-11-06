import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConvenientTopBanner extends StatelessWidget {
  const ConvenientTopBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Stack(children: [
        Container(
            padding: EdgeInsets.fromLTRB(155, 10, 0, 0),
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'assets/convenient/${Get.arguments['name']}.jpg')),
            )),
        Align(
          alignment: Alignment.center,
          child: Text(
            Get.arguments['category'].toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }
}
