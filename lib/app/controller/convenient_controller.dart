import 'package:get/get.dart';
import 'package:gnumap/app/data/model/convenient_model.dart';
import 'package:gnumap/app/data/repository/convenient_repository.dart';

class ConvenientController extends GetxController {
  final ConvenientRepository repository;
  ConvenientController({required this.repository}) : assert(repository != null);

  final _convenientsList = <ConvenientModel>[].obs;

  final _convenient = ConvenientModel().obs;

  get convenientsList => _convenientsList.value;

  set convenientsList(value) => _convenientsList.value = value;

  get convenient => _convenient.value;

  set convenient(value) => _convenient.value = value;

  getAll(String category) {
    repository.getAll(category).then((data) {
      convenientsList = data;
    });
  }
}
