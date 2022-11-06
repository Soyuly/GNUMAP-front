import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/history_controller.dart';
import 'package:gnumap/app/data/model/history_model.dart';

class HistoryItems extends GetView<HistoryController> {
  const HistoryItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      child: GetX<HistoryController>(
        initState: (state) {
          Get.find<HistoryController>().getHistories();
        },
        builder: (_) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _.items.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                  child: TextButton(
                    onLongPress: () async {
                      showCupertinoDialog(
                          context: context,
                          useRootNavigator: false,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text('히스토리 항목 삭제'),
                              content: Text(
                                  '히스토리${_.items[index].name}를 정말 삭제하시겠습니까?'),
                              actions: [
                                CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: Text(
                                      "삭제",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      print('삭제');
                                      await _.deleteHistory(_.items[index]);

                                      Navigator.pop(context);
                                    }),
                                CupertinoDialogAction(
                                    isDefaultAction: true,
                                    child: Text("취소"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            );
                          });
                    },
                    onPressed: () {
                      Get.toNamed("/result",
                          arguments: {"keyword": _.items[index].name});
                    },
                    child: Text(_.items[index].name,
                        style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context).primaryColor,
                            fontFamily: 'AppleSDGothicNeo')),
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(10, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft),
                  ),
                );
              });
        },
      ),
    );
  }
}
