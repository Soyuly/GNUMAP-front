import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/convenient_controller.dart';
import 'package:gnumap/app/utils/storage_service.dart';

class ConvenientItem extends GetView<ConvenientController> {
  final String name;
  final String phone;
  final String lat;
  final String lng;
  final int distance;
  final int time;
  final String open;
  final String close;
  const ConvenientItem(
      {Key? key,
      required this.name,
      required this.phone,
      required this.lat,
      required this.lng,
      required this.distance,
      required this.time,
      required this.open,
      required this.close})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Storage storage = Storage();
    return GestureDetector(
      onTap: () {
        Get.toNamed('/path/convenient',
            arguments: {'lat': lat, 'lng': lng, 'name': name});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: storage.downloadURL("convenients", name + ".jpg"),
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
                Container(
                  height: 100,
                  padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            phone,
                            style: TextStyle(
                                fontSize: 13, fontFamily: 'Pretendard'),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          time < 90
                              ? Text(
                                  '소요거리 : ${distance}m, 소요시간 : ${time}분',
                                  style: TextStyle(
                                      fontSize: 13, fontFamily: 'Pretendard'),
                                )
                              : Text(
                                  '소요거리, 소요시간 알수없음',
                                  style: TextStyle(
                                      fontSize: 13, fontFamily: 'Pretendard'),
                                ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text("운영시간: $open ~ $close",
                                style: TextStyle(
                                    fontSize: 12, fontFamily: 'Pretendard')),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            color: Color(0xffB9B9B9),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
