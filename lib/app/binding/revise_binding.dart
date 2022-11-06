import 'package:get/get.dart';
import 'package:gnumap/app/controller/revise_controller.dart';
import 'package:gnumap/app/data/provider/revise_post_api.dart';
import 'package:gnumap/app/data/repository/revise_repository.dart';
import 'package:http/http.dart' as http;

class ReviseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviseController>(() {
      return ReviseController(
          repository: ReviseRepository(
              apiClient: ReviseApiClient(httpClient: http.Client())));
    });
  }
}
