import 'package:json_annotation/json_annotation.dart';

part 'brand.g.dart';

@JsonSerializable()
class Brand {
  String idBrand;
  String name;
  String logoBrand;

  Brand(
    this.idBrand,
    this.name,
    this.logoBrand,
  );

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  Map<String, dynamic> toJson() => _$BrandToJson(this);
}
