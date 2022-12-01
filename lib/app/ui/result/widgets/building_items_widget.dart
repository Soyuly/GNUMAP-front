import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/utils/storage_service.dart';

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
    Storage storage = Storage();
    return GestureDetector(
      onTap: () => Get.toNamed('/path',
          arguments: {'name': name, 'num': num, 'lat': lat, 'lng': lng}),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [
            Row(
              children: [
                FutureBuilder(
                  future: storage.downloadURL(
                      "buildings", num.toString() + ".jpeg"),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          snapshot.data!,
                          fit: BoxFit.cover,
                          width: 110,
                          height: 110,
                        ),
                        // 'assets/convenient/cafe.jpg')),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        !snapshot.hasData) {
                      return SizedBox(
                        width: 110,
                        height: 110,
                      );
                    }
                    return SizedBox(
                      width: 110,
                      height: 110,
                    );
                  },
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
