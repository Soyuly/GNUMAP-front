import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/area_controller.dart';
import 'package:gnumap/app/controller/building_path_info_controller.dart';

class CampusSelect extends StatefulWidget {
  const CampusSelect({Key? key}) : super(key: key);

  @override
  _CampusSelectState createState() => _CampusSelectState();
}

class _CampusSelectState extends State<CampusSelect> {
  String dropdownValue = '가좌';

  @override
  Widget build(BuildContext context) {
    Get.put(AreaController());
    return Container(
      height: 40,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Color.fromRGBO(0, 140, 216, 1)),
      child: DropdownButton<String>(
        value: dropdownValue, // 디폴트값 설정
        items: [
          DropdownMenuItem(
            child: Text(
              "가좌캠",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600),
            ),
            value: "가좌",
          ),
          DropdownMenuItem(
            child: Text(
              "칠암캠",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600),
            ),
            value: "칠암",
          ),
          DropdownMenuItem(
              child: Text(
                "의간캠",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600),
              ),
              value: "의간"),
          DropdownMenuItem(
            child: Text(
              "통영캠",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600),
            ),
            value: "통영",
          )
        ],
        onChanged: (value) {
          Get.find<AreaController>().area = value;
          setState(() {
            dropdownValue = value!;
          });
        },
        iconEnabledColor: Colors.white, //Icon color
        style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600),
        dropdownColor:
            Color.fromRGBO(0, 140, 216, 1), //dropdown background color
        underline: Container(), //remove underline
      ),
    );
  }
}
