import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/revise_controller.dart';
import 'package:gnumap/app/data/model/revise_model.dart';
import 'package:gnumap/app/data/provider/revise_post_api.dart';
import 'package:gnumap/app/data/repository/revise_repository.dart';
import 'package:http/http.dart' as http;

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _revise = Get.put(ReviseController(
        repository: ReviseRepository(
            apiClient: ReviseApiClient(httpClient: http.Client()))));
    return ElevatedButton(
        onPressed: () async {
          _revise.postRevise(_revise.item);
        },
        child: Text("보내기"),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          minimumSize: Size(15.0, 20.0),
        ));
  }
}
