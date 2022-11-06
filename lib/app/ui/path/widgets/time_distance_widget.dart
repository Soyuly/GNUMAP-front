import 'package:get/get.dart';
import 'package:gnumap/app/controller/path_info_controller.dart';
import 'package:flutter/material.dart';

class TimeAndDistance extends GetView<PathInfoController> {
  const TimeAndDistance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.refresh,
                          size: 35.0,
                        ),
                        onPressed: () {
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (BuildContext context) => super.widget));
                          print('search button is clicked');
                        }),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Text('소요거리',
                              style: Theme.of(context).textTheme.headline6),
                        ),
                        Text('${_.pathInfo.distance.toString()}m',
                            style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Text('소요시간',
                              style: Theme.of(context).textTheme.headline6),
                        ),
                        Container(
                          child: Text('${_.pathInfo.time.toString()}분',
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                  ],
                )),
    );
  }
}
