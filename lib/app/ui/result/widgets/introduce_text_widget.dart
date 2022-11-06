import 'package:flutter/material.dart';

class IntroduceText extends StatelessWidget {
  const IntroduceText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Text(
        '찾으시려는 건물을\n선택 해주세요.',
        style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontFamily: 'AppleSDGothicNeo',
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
