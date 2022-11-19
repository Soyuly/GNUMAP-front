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
      margin: const EdgeInsets.fromLTRB(0, 8, 13, 0),
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
          if (name.trim() == "") {
            Get.dialog(CupertinoAlertDialog(
              title: Text('검색어가 올바르지 않습니다.'),
              content: Text('건물번호 또는 건물명을 다시 입력해주세요.'),
              actions: [
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text("확인"),
                    onPressed: () {
                      Get.back();
                    })
              ],
            ));
            return;
          }
          final history = History(name: name);
          Get.find<HistoryController>().addHistory(history);
          Get.toNamed("/result", arguments: {"keyword": name});
        },
      ),
    ));
  }
}
