class PathInfo {
  int distance = 0;
  int time = 9999;

  PathInfo({distance, time});

  PathInfo.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    time = json['time'];
  }
}
