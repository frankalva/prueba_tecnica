import 'package:hive/hive.dart';

part 'preference_model.g.dart'; 

@HiveType(typeId: 0)
class Preference extends HiveObject {
  @HiveField(0)
  final int apiId;

  @HiveField(1)
  final String customName;

  @HiveField(2)
  final String thumbnailUrl;

  Preference({
    required this.apiId,
    required this.customName,
    required this.thumbnailUrl,
  });
}