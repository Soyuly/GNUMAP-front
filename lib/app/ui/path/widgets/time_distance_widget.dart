import 'package:get/get.dart';
import 'package:gnumap/app/controller/my_pos_controller.dart';
import 'package:gnumap/app/controller/path_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:gnumap/app/data/provider/my_pos_provider.dart';
import 'package:gnumap/app/data/repository/my_pos_repository.dart';

class TimeAndDistance extends GetView<PathInfoController> {
  const TimeAndDistance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyPosController(
        repository: MyPosRepository(myPosClient: MyPosClient())));
    return Expanded(
      flex: 1,
      child: GetX<PathInfoController>(
          initState: (state) {
            Get.find<PathInfoController>()
                .getInfo(Get.arguments['lat'], Get.arguments['lng']);
          },
          builder: (_) => _.pathInfo.time == 9999
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.refresh,
                          size: 25.0,
                        ),
                        onPressed: () {
                          controller.setPath();
                          Get.toNamed('/path', arguments: {
                            'name': Get.arguments['name'],
                            'num': Get.arguments['num'],
                            'lat': controller.me.lat,
                            'lng': controller.me.lng
                          });
                        }),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Text('소요거리',
                              style: Theme.of(context).textTheme.headline6),
                        ),
                        _.pathInfo.distance < 30000
                            ? Text(
                                _.pathInfo.distance >= 1000
                                    ? '${_.pathInfo.distance / 1000.toString()}km'
                                    : '${_.pathInfo.distance.toString()}m',
                                style: Theme.of(context).textTheme.subtitle1)
                            : Text('알수없음',
                                style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Text('소요시간',
                                style: Theme.of(context).textTheme.headline6)),
                        _.pathInfo.time < 90
                            ? Text('${_.pathInfo.time.toString()}분',
                                style: Theme.of(context).textTheme.subtitle1)
                            : Text('알수없음',
                                style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                    SizedBox(width: 20),
                  ],
                )),
    );
  }
}
