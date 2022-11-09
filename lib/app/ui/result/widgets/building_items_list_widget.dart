import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/building_path_info_controller.dart';
import 'package:gnumap/app/controller/my_pos_controller.dart';
import 'package:gnumap/app/ui/result/widgets/building_items_widget.dart';

class BuildingItemsList extends GetView<BuildingPathInfoController> {
  const BuildingItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX<BuildingPathInfoController>(
        initState: (state) {
          Get.find<MyPosController>().setPath();
          Get.find<BuildingPathInfoController>()
              .getAll(Get.arguments['keyword']);
        },
        builder: (_) {
          print(_.buildingsList);
          return _.buildingsList.length < 1
              ? (_.hasData)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Text(
                        '검색결과가 없습니다',
                        style: TextStyle(fontSize: 14),
                      ),
                    )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _.buildingsList.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: BuildingItem(
                          num: _.buildingsList[index].num,
                          name: _.buildingsList[index].name,
                          distance: _.buildingsList[index].distance,
                          time: _.buildingsList[index].time,
                          lat: _.buildingsList[index].lat,
                          lng: _.buildingsList[index].lng),
                    );
                  });
        },
      ),
    );
  }
}
