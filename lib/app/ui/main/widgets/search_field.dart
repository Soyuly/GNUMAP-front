import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/history_controller.dart';
import 'package:gnumap/app/data/model/history_model.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  String text = "";
  TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Get.put(HistoryController());

    return SafeArea(
        child: Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 13, 0),
      child: CupertinoSearchTextField(
        placeholder: "search_placeholder".tr,
        controller: _search,
        itemSize: 20,
        onChanged: (value) {
          if (value.length <= 10) {
            text = value;
          } else {
            _search.text = text;
            _search.selection = TextSelection.fromPosition(
                TextPosition(offset: _search.text.length));
          }
        },
        decoration: BoxDecoration(
            color: Color.fromRGBO(188, 188, 188, 0.54),
            borderRadius: BorderRadius.circular(10)),
        onSubmitted: (name) async {
          final history = History(name: name);
          Get.find<HistoryController>().addHistory(history);
          Get.toNamed("/result", arguments: {"keyword": name});
        },
      ),
    ));
  }
}
