import 'package:json_annotation/json_annotation.dart';
import 'package:selling_food_store/models/product.dart';

part 'detail_brand.g.dart';

@JsonSerializable()
class DetailBrand {
  String idBrand;
  String name;
  String logo;
  String address;
  String? desc;
  List<Product> products;

  DetailBrand(
    this.idBrand,
    this.name,
    this.logo,
    this.address,
    this.desc,
    this.products,
  );

  factory DetailBrand.fromJson(Map<String, dynamic> json) =>
      _$DetailBrandFromJson(json);

  Map<String, dynamic> toJson() => _$DetailBrandToJson(this);
}
