import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:gnumap/app/controller/my_pos_controller.dart';
import 'package:gnumap/app/data/model/convenient_model.dart';
import 'package:gnumap/app/data/provider/my_pos_provider.dart';
import 'package:gnumap/app/data/repository/my_pos_repository.dart';
import 'package:gnumap/app/utils/constants.dart';
import 'package:http/http.dart' as http;

class ConvenientClient {
  final http.Client httpClient;
  final controller = Get.put(
      MyPosController(repository: MyPosRepository(myPosClient: MyPosClient())));
  ConvenientClient({required this.httpClient});

  getAll(String category) async {
    final baseUrl = Uri.parse(BASE_URL +
        '/v1/convenient/' +
        controller.me.value.lat.toString() +
        '/' +
        controller.me.value.lng.toString() +
        '/' +
        category);

    try {
      var response = await httpClient.get(baseUrl);
      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body);
        List<ConvenientModel> listConvenientModel = jsonResponse
            .map((model) => ConvenientModel.fromJson(model))
            .toList();
        return listConvenientModel;
      } else {
        log("편의시설 리스트 받아오기 오류" + response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
