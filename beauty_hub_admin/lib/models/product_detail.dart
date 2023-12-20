import 'package:json_annotation/json_annotation.dart';

import 'brand.dart';
import 'category.dart';

part 'product_detail.g.dart';

@JsonSerializable()
class ProductDetail {
  String idProduct;
  String name;
  String image;
  String description;
  double cost;
  double? discount;
  String? introduce;
  List<String>? ingredients;
  List<String> uses;
  List<String> howToUse;
  String origin;
  List<String>? tags;
  Brand brand;
  List<Category> categories;
  double? sold;

  ProductDetail(
    this.idProduct,
    this.name,
    this.image,
    this.description,
    this.cost,
    this.discount,
    this.introduce,
    this.ingredients,
    this.uses,
    this.howToUse,
    this.origin,
    this.tags,
    this.brand,
    this.categories,
    this.sold,
  );

  factory ProductDetail.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);

   Map<String, dynamic> convertToJson() {
    return {
      "idProduct": idProduct,
      "name": name,
      "image": image,
      "description": description,
      "cost": cost,
      "discount": discount,
      "brand": brand.toJson(),
      "categories": categories.map((e) => e.toJson()).toList(),
      "sold": sold,
    };
  }

  double getPrice() {
    return discount != null && discount != 0.0
        ? cost - cost * (discount! / 100.0)
        : cost;
  }
}
