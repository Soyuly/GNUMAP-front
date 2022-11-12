import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildingItem extends StatelessWidget {
  final int num;
  final String name;
  final int distance;
  final int time;
  final String lat;
  final String lng;
  const BuildingItem(
      {Key? key,
      required this.num,
      required this.name,
      required this.distance,
      required this.time,
      required this.lat,
      required this.lng})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/path',
          arguments: {'name': name, 'num': num, 'lat': lat, 'lng': lng}),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  child: Image.asset(
                    'assets/buildings/$num.jpeg',
                    width: 110,
                    height: 98,
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                SizedBox(
                  width: 15,
                ),
                SizedBox(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$num동',
                            style: Get.isDarkMode
                                ? TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontFamily: 'AppleSDGothicNeo',
                                    fontWeight: FontWeight.w600)
                                : TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontFamily: 'AppleSDGothicNeo',
                                    fontWeight: FontWeight.w600),
                          ),
                          Text(
                            name,
                            style: Get.isDarkMode
                                ? TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'AppleSDGothicNeo',
                                    fontWeight: FontWeight.w600)
                                : TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: 'AppleSDGothicNeo',
                                    fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      time < 90
                          ? Text(
                              distance >= 1000
                                  ? '여기에서 ${distance / 1000}km, $time분'
                                  : '여기에서 ${distance}m, $time분',
                              style: Get.isDarkMode
                                  ? TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                      fontFamily: 'AppleSDGothicNeo',
                                    )
                                  : TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff0B40FF),
                                      fontFamily: 'AppleSDGothicNeo',
                                    ))
                          : Text(
                              '소요거리, 소요시간 알수없음',
                              style: Get.isDarkMode
                                  ? TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                      fontFamily: 'AppleSDGothicNeo',
                                    )
                                  : TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff0B40FF),
                                      fontFamily: 'AppleSDGothicNeo',
                                    ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              height: 1,
              color: Color(0xff767676),
            ),
          ],
        ),
      ),
    );
  }
}
