import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GnuMapTitle extends StatelessWidget {
  const GnuMapTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: EdgeInsets.fromLTRB(10, 0, 23, 0),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            Get.toNamed('/map');
          },
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('GNU MAP', style: Theme.of(context).textTheme.headline3),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ]),
        ),
      ),
    );
  }
}
