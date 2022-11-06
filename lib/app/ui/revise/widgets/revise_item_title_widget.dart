import 'package:flutter/material.dart';

class ReviseItemTitle extends StatelessWidget {
  final String name;
  const ReviseItemTitle({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
        child: Text(
          name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'AppleSDGothicNeo',
            color: Color.fromRGBO(0, 0, 0, 0.69),
          ),
        ));
  }
}
