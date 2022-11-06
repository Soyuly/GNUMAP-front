class MyPos {
  double lat = 0.0;
  double lng = 0.0;

  MyPos({lat, lng});

  MyPos.setData(lat, lng) {
    this.lat = lat;
    this.lng = lng;
  }

  MyPos.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}
