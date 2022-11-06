import 'package:hive/hive.dart';

part 'favorites_model.g.dart';

@HiveType(typeId: 1)
class Favorites {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int num;

  Favorites({required this.name, required this.num});
}
