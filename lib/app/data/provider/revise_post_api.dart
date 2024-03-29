import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/my_pos_controller.dart';
import 'package:gnumap/app/controller/revise_controller.dart';
import 'package:gnumap/app/data/model/path_info_model.dart';
import 'package:gnumap/app/data/model/revise_model.dart';
import 'package:gnumap/app/data/provider/my_pos_provider.dart';
import 'package:gnumap/app/data/repository/my_pos_repository.dart';
import 'package:gnumap/app/data/repository/revise_repository.dart';
import 'package:gnumap/app/utils/constants.dart';
import 'package:http/http.dart' as http;

var baseUrl = Uri.parse(BASE_URL + '/v1/revise');

class ReviseApiClient {
  final http.Client httpClient;

  ReviseApiClient({required this.httpClient});

  postRevise(ReviseModel revise) async {
    final Map<String, String> params = {
      "title": revise.title,
      "body": revise.body
    };
    try {
      var response = await httpClient.post(baseUrl, body: params);

      if (response.statusCode == 200) {
        var result = jsonDecode(utf8.decode(response.bodyBytes));

        if (result['code'] == 2000) {
          Get.find<ReviseController>().success = false;
          return;
        }

        Get.find<ReviseController>().success = true;
      } else {
        Get.find<ReviseController>().success = false;
      }
    } catch (e) {
      Get.find<ReviseController>().success = false;
    }
  }
}
