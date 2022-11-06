class BuildingModel {
  late int num;
  late String name;
  late String lat;
  late String lng;
  late int distance;
  late int time;

  BuildingModel({num, lat, lng, distance, time});

  BuildingModel.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    name = json['name'];
    lat = json['lat'];
    lng = json['lng'];
    distance = json['distance'];
    time = json['time'];
  }
}
