import 'dart:developer';

import 'package:get/get.dart';
import 'package:gnumap/app/data/model/path_info_model.dart';
import 'package:gnumap/app/data/repository/path_info_repository.dart';
import 'package:gnumap/app/data/repository/my_pos_repository.dart';

import '../data/model/my_pos_model.dart';

class MyPosController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setPath();
  }

  final MyPosRepository repository;
  MyPosController({required this.repository}) : assert(repository != null);
  final _me = MyPos().obs;

  get me => _me;

  set me(value) => _me.value = value;

  setPath() {
    repository.setPath().then((data) {
      log("고고");
      me = data;
      log("성공");
    });
  }
}
