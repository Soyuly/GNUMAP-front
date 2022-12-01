import 'package:flutter/material.dart';

class DeveloperInfo extends StatelessWidget {
  const DeveloperInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
            child: Text(
              '제작자 정보',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Text('경상대학교 컴퓨터과학과 :: 18CLASS',
              style: Theme.of(context).textTheme.bodyText2),
          Text('컴퓨터과학과 18학번 전병규', style: Theme.of(context).textTheme.bodyText2),
          Text('컴퓨터과학과 18학번 양소열', style: Theme.of(context).textTheme.bodyText2),
          Text('컴퓨터과학과 18학번 정윤수', style: Theme.of(context).textTheme.bodyText2),
          Text('컴퓨터과학과 18학번 강동현', style: Theme.of(context).textTheme.bodyText2),
          Text('정보통계학과 18학번 이지상', style: Theme.of(context).textTheme.bodyText2),
        ],
      ),
    );
  }
}
