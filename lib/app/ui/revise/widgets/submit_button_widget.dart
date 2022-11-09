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
          await _revise.postRevise(_revise.item);

          if (Get.find<ReviseController>().success) {
            Get.back();
            Get.snackbar(
              '전송 성공!',
              '문의사항이 정상적으로 전달 되었습니다. 검토 후 2 ~ 3일 내에 반영 될 예정입니다.',
              colorText: Colors.blue,
              snackPosition: SnackPosition.TOP,
            );
          } else {
            Get.snackbar(
              '전송 실패',
              '문의사항이 정상적으로 전달 되지 않았습니다. 잠시 후 다시 시도해주세요.',
              colorText: Colors.red,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        child: Text("보내기"),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          minimumSize: Size(15.0, 20.0),
        ));
  }
}
