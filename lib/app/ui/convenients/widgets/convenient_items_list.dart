import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/controller/convenient_controller.dart';
import 'package:gnumap/app/ui/convenients/widgets/convenient_items.dart';

class ConvenientItemsList extends GetView<ConvenientController> {
  const ConvenientItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Container(
          padding: EdgeInsets.fromLTRB(17, 15, 17, 6),
          child: GetX<ConvenientController>(
            initState: (state) {
              Get.find<ConvenientController>()
                  .getAll(Get.arguments['category']);
            },
            builder: (_) {
              return _.convenientsList.length < 1
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: _.convenientsList.length,
                      itemBuilder: (context, index) {
                        return ConvenientItem(
                            name: _.convenientsList[index].name,
                            phone: _.convenientsList[index].phone,
                            lat: _.convenientsList[index].lat,
                            lng: _.convenientsList[index].lng,
                            distance: _.convenientsList[index].distance,
                            time: _.convenientsList[index].time,
                            open: _.convenientsList[index].open,
                            close: _.convenientsList[index].close);
                      });
            },
          )),
    );
  }
}
