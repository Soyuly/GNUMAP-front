import 'package:get/get.dart';
import 'package:gnumap/app/controller/convenient_controller.dart';
import 'package:gnumap/app/data/provider/convenient_list_api.dart';
import 'package:gnumap/app/data/repository/convenient_repository.dart';
import 'package:http/http.dart' as http;

class ConvenientBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConvenientController>(() {
      return ConvenientController(
          repository: ConvenientRepository(
              apiClient: ConvenientClient(httpClient: http.Client())));
    });
  }
}
