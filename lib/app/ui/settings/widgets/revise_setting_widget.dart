import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/routes/app_pages.dart';
import 'package:gnumap/app/ui/revise/revise_info.dart';

class ReviseSetting extends StatelessWidget {
  const ReviseSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
            child: Text(
              "revise_setting".tr,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Text("revise_description".tr,
              style: Theme.of(context).textTheme.bodyText2),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.REVISE);
              },
              child: Text("go_to_revise".tr),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent),
                  padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                  textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 13))),
            ),
          ),
        ],
      ),
    );
  }
}
