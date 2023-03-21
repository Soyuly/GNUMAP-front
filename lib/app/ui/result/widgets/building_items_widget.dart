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
  final String area;
  const BuildingItem(
      {Key? key,
      required this.num,
      required this.name,
      required this.distance,
      required this.time,
      required this.lat,
      required this.lng,
      required this.area})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String eng_area;
    switch (area) {
      case '통영':
        eng_area = "tongyeong";
        break;
      case '칠암':
        eng_area = 'chilam';
        break;
      case '의간':
        eng_area = 'medical';
        break;
      case '가좌':
        eng_area = 'gajwa';
        break;
    }
    Storage storage = Storage();
    return GestureDetector(
      onTap: () => Get.toNamed('/path', arguments: {
        'name': name,
        'num': num,
        'lat': lat,
        'lng': lng,
        'area': eng_area
      }),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          children: [
            Row(
              children: [
                FutureBuilder(
                  future: storage.downloadURL(
                      "buildings/$eng_area", num.toString() + ".jpeg"),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          snapshot.data!,
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        ),
                        // 'assets/convenient/cafe.jpg')),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      print(snapshot.data);
                      return SizedBox(
                        width: 110,
                        height: 130,
                      );
                    }

                    if (!snapshot.hasData) {
                      print("여기로");
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
                  width: 200,
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$num동',
                            style: Get.isDarkMode
                                ? TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600)
                                : TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600),
                          ),
                          Text(
                            name,
                            style: Get.isDarkMode
                                ? TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600)
                                : TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600),
                            softWrap: true,
                          ),
                        ],
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
                                      fontFamily: 'Pretendard',
                                    )
                                  : TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff0B40FF),
                                      fontFamily: 'Pretendard',
                                    ))
                          : Text(
                              '소요거리, 소요시간 알수없음',
                              style: Get.isDarkMode
                                  ? TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                      fontFamily: 'Pretendard',
                                    )
                                  : TextStyle(
                                      fontSize: 15,
                                      color: Color(0xff0B40FF),
                                      fontFamily: 'Pretendard',
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
