class ConvenientModel {
  late String name;
  late String phone;
  late String lat;
  late String lng;
  late String open;
  late String close;
  late String category;
  late int distance;
  late int time;

  ConvenientModel(
      {name, phone, lat, lng, open, close, category, distance, time});

  ConvenientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    lat = json['lat'];
    lng = json['lng'];
    open = json['open'];
    close = json['close'];
    category = json['category'];
    distance = json['distance'];
    time = json['time'];
  }
}
