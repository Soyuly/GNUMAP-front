import 'dart:developer';

import 'package:get/get.dart';
import 'package:gnumap/app/data/model/revise_model.dart';
import 'package:gnumap/app/data/repository/revise_repository.dart';

class ReviseController extends GetxController {
  final ReviseRepository repository;
  ReviseController({required this.repository}) : assert(repository != null);

  final _item = ReviseModel().obs;

  get item => _item.value;
  set item(value) => _item.value = value;

  postRevise(ReviseModel reviseModel) {
    try {
      repository.postRevise(reviseModel);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
