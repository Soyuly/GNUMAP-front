import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gnumap/app/ui/revise/widgets/body_textfield_widget.dart';
import 'package:gnumap/app/ui/revise/widgets/revise_item_title_widget.dart';
import 'package:gnumap/app/ui/revise/widgets/title_textfield_widget.dart';
import 'package:gnumap/app/ui/revise/widgets/submit_button_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

class ReviseInfo extends StatefulWidget {
  const ReviseInfo({Key? key}) : super(key: key);

  @override
  State<ReviseInfo> createState() => _ReviseInfoState();
}

class _ReviseInfoState extends State<ReviseInfo> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  void _clear() {
    _titleController.clear();
    _bodyController.clear();
  }

  @override
  void dispose() {
    _titleController.clear();
    _bodyController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemBackground,
          middle:
              Text('문의사항 보내기', style: Theme.of(context).textTheme.headline5),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(children: [
              ReviseItemTitle(name: "제목"),
              SizedBox(height: 3),
              TitleTextField(),
              ReviseItemTitle(name: "수정내용"),
              SizedBox(height: 3),
              BodyTextField(),
              SizedBox(height: 15),
              SubmitButton(),
            ])));
  }
}
