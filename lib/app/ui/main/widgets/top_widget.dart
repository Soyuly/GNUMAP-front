import 'package:flutter/material.dart';
import 'package:gnumap/app/ui/main/widgets/campus_select_widget.dart';
import 'package:gnumap/app/ui/main/widgets/search_field.dart';

class MainTopWidget extends StatelessWidget {
  const MainTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CampusSelect(),
            flex: 2,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: SearchField(),
            flex: 8,
          )
        ],
      ),
    );
  }
}
