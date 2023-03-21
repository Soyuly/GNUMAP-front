import 'package:hive/hive.dart';

part 'favorites_model.g.dart';

@HiveType(typeId: 1)
class Favorites {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int num;

  @HiveField(2)
  final String lat;

  @HiveField(3)
  final String lng;

  @HiveField(4)
  final String area;

  Favorites(
      {required this.name,
      required this.num,
      required this.lat,
      required this.lng,
      required this.area});
}
