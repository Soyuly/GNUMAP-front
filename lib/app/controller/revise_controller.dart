import 'dart:developer';

import 'package:get/get.dart';
import 'package:gnumap/app/data/model/revise_model.dart';
import 'package:gnumap/app/data/repository/revise_repository.dart';

class ReviseController extends GetxController {
  final ReviseRepository repository;
  ReviseController({required this.repository}) : assert(repository != null);

  final _item = ReviseModel().obs;
  final _success = true.obs;

  get item => _item.value;
  set item(value) => _item.value = value;

  get success => _success.value;
  set success(value) => _success.value = value;

  postRevise(ReviseModel reviseModel) {
    repository.postRevise(reviseModel);
  }
}
