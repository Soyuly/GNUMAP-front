import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/revise_controller.dart';
import 'package:gnumap/app/data/provider/revise_post_api.dart';
import 'package:gnumap/app/data/repository/revise_repository.dart';
import 'package:http/http.dart' as http;

class BodyTextField extends StatelessWidget {
  const BodyTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    final _revise = Get.put(ReviseController(
        repository: ReviseRepository(
            apiClient: ReviseApiClient(httpClient: http.Client()))));

    return TextField(
      minLines: 10,
      maxLines: null,
      maxLength: 200,
      decoration: InputDecoration(
        hintText: "내용을 입력해주세요.",
        hintStyle: Get.isDarkMode
            ? TextStyle(
                fontSize: 13,
                fontFamily: 'AppleSDGothicNeo',
                color: Colors.white)
            : TextStyle(
                fontSize: 13,
                fontFamily: 'AppleSDGothicNeo',
                color: Color.fromRGBO(0, 0, 0, 0.6)),
      ),
      controller: _controller,
      style: Get.isDarkMode
          ? TextStyle(
              fontSize: 14, fontFamily: 'AppleSDGothicNeo', color: Colors.white)
          : TextStyle(
              fontSize: 14,
              fontFamily: 'AppleSDGothicNeo',
              color: Color.fromRGBO(0, 0, 0, 0.9)),
      onChanged: (value) => {_revise.item.body = _controller.text},
    );
  }
}
