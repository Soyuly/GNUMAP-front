import 'package:hive/hive.dart';

part 'history_model.g.dart';

@HiveType(typeId: 2)
class History {
  @HiveField(0)
  final String name;

  @HiveField(1, defaultValue: "가좌")
  final String area;

  History({required this.name, required this.area});
}
