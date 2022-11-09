import 'package:get/get_core/src/get_main.dart';
import 'package:gnumap/app/ui/convenients/widgets/convenient_items_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConvenientPage extends StatelessWidget {
  const ConvenientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemBackground,
          middle: Text(
            Get.arguments['title'],
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: Container(
          child: Column(children: [
            ConvenientItemsList(),
          ]),
        ),
      ),
    );
  }
}
