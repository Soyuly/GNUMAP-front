import 'package:flutter/material.dart';
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
                      ConvenientsItem(title: "편의점", name: "편의점"),
                      ConvenientsItem(title: "ATM", name: "atm"),
                      ConvenientsItem(title: "우체국", name: "postoffice"),
                      ConvenientsItem(title: "문구점", name: "stationary"),
                      ConvenientsItem(title: "운동", name: "운동장1"),
                    ]))),
        SafeArea(
            child: Container(
                margin: EdgeInsets.fromLTRB(5, 0, 15, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ConvenientsItem(title: "딸기방", name: "strawberry"),
                      ConvenientsItem(title: "식당", name: "cafeteria"),
                      ConvenientsItem(title: "프린터", name: "printer"),
                      ConvenientsItem(title: "카페", name: "cafe"),
                      ConvenientsItem(title: "헌혈의집", name: "blood"),
                    ])))
      ],
    );
  }
}
