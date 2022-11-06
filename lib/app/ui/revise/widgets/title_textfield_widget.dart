import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/revise_controller.dart';
import 'package:gnumap/app/data/provider/revise_post_api.dart';
import 'package:gnumap/app/data/repository/revise_repository.dart';
import 'package:http/http.dart' as http;

class TitleTextField extends StatelessWidget {
  const TitleTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    final _revise = Get.put(ReviseController(
        repository: ReviseRepository(
            apiClient: ReviseApiClient(httpClient: http.Client()))));
    return TextField(
      maxLength: 15,
      decoration: InputDecoration(
        hintText: "건물명을 입력해주세요.",
        hintStyle: TextStyle(
            fontSize: 13,
            fontFamily: 'AppleSDGothicNeo',
            color: Color.fromRGBO(0, 0, 0, 0.6)),
      ),
      controller: _controller,
      style: TextStyle(
        fontFamily: 'AppleSDGothicNeo',
      ),
      onChanged: (value) => {_revise.item.title = value},
    );
  }
}
