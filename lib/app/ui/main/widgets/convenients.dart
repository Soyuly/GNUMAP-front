import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/ui/main/widgets/convenients_item.dart';

class Conveneints extends StatelessWidget {
  const Conveneints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
            child: Container(
                margin: EdgeInsets.fromLTRB(5, 0, 15, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ConvenientsItem(
                        api: "편의점",
                        name: "convenientstore",
                        title: "convenient_store".tr,
                      ),
                      ConvenientsItem(
                        api: "ATM",
                        name: "atm",
                        title: "atm".tr,
                      ),
                      ConvenientsItem(
                        api: "우체국",
                        name: "postoffice",
                        title: "post_office".tr,
                      ),
                      ConvenientsItem(
                        api: "문구점",
                        name: "stationary",
                        title: "stationery_store".tr,
                      ),
                      ConvenientsItem(
                          api: "운동", name: "운동", title: "exercise".tr),
                    ]))),
        SafeArea(
            child: Container(
                margin: EdgeInsets.fromLTRB(5, 0, 15, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ConvenientsItem(
                        api: "딸기방",
                        name: "strawberry",
                        title: "strawberry".tr,
                      ),
                      ConvenientsItem(
                          api: "식당", name: "cafeteria", title: "cafeteria".tr),
                      ConvenientsItem(
                        api: "프린터",
                        name: "printer",
                        title: "printer".tr,
                      ),
                      ConvenientsItem(
                        api: "카페",
                        name: "cafe",
                        title: "cafe".tr,
                      ),
                      ConvenientsItem(
                        api: "헌혈의집",
                        name: "blood",
                        title: "blood".tr,
                      ),
                    ])))
      ],
    );
  }
}
