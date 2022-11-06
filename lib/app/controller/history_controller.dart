import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/data/model/favorites_model.dart';
import 'package:gnumap/app/data/model/history_model.dart';
import 'package:hive/hive.dart';

class HistoryController extends GetxController {
  final _items = [].obs;

  get items => _items;

  set items(value) => _items.value = value;

  @override
  void onInit() {
    // TODO: implement onInit
    try {
      Hive.registerAdapter(HistoryAdapter());
    } catch (e) {
      log("Hive 즐겨찾기 에러 : " + e.toString());
    }
    getHistories();
    super.onInit();
  }

  addHistory(History history) async {
    // History 중복처리
    final isExisted = (items.firstWhere((item) => item.name == history.name,
        orElse: () => false));
    if (isExisted == false && items.length < 10) {
      items.insert(0, history);
    } else if (isExisted == false && items.length >= 10) {
      deleteHistory(items[10]);
      items.insert(0, history);
    }
    var box = await Hive.openBox('history');
    box.put('history', items.toList());
    log('History 아이템 추가 되었음 $history');
  }

  Future getHistories() async {
    Box box;
    try {
      box = Hive.box('history');
    } catch (e) {
      box = await Hive.openBox('history');
    }

    var history = box.get('history');
    if (history != null) items = history;
  }

  deleteHistory(History history) async {
    items.remove(history);
    var box = await Hive.openBox('history');
    box.put('history', items.toList());
  }
}
