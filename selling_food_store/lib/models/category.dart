import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Category extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'category_id')
  String id;
  @HiveField(1)
  String name;

  Category(this.id, this.name);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
