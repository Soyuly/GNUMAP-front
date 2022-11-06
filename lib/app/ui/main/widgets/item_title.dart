import 'package:flutter/material.dart';

class ItemTitle extends StatelessWidget {
  final String title;

  const ItemTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      margin: EdgeInsets.fromLTRB(6, 5, 0, 0),
      alignment: Alignment.topLeft,
      child: Text(title, style: Theme.of(context).textTheme.headline2),
    );
  }
}
