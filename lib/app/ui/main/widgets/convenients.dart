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
                        appbar: "convenient_store_title".tr,
                      ),
                      ConvenientsItem(
                        api: "ATM",
                        name: "atm",
                        title: "atm".tr,
                        appbar: "atm_title".tr,
                      ),
                      ConvenientsItem(
                        api: "우체국",
                        name: "postoffice",
                        title: "post_office".tr,
                        appbar: "post_office_title".tr,
                      ),
                      ConvenientsItem(
                        api: "문구점",
                        name: "stationary",
                        title: "stationery_store".tr,
                        appbar: "stationery_title".tr,
                      ),
                      ConvenientsItem(
                          api: "운동",
                          name: "운동",
                          title: "exercise".tr,
                          appbar: "exercise_title".tr),
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
                        appbar: "strawberry_title".tr,
                      ),
                      ConvenientsItem(
                        api: "식당",
                        name: "cafeteria",
                        title: "cafeteria".tr,
                        appbar: "cafeteria_title".tr,
                      ),
                      ConvenientsItem(
                        api: "프린터",
                        name: "printer",
                        title: "printer".tr,
                        appbar: "printer_title".tr,
                      ),
                      ConvenientsItem(
                        api: "카페",
                        name: "cafe",
                        title: "cafe".tr,
                        appbar: "cafe_title".tr,
                      ),
                      ConvenientsItem(
                        api: "헌혈의집",
                        name: "blood",
                        title: "blood".tr,
                        appbar: "blood_title".tr,
                      ),
                    ])))
      ],
    );
  }
}
