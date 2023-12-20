import 'package:json_annotation/json_annotation.dart';

import 'brand.dart';
import 'category.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  String idProduct;
  String name;
  String image;
  String description;
  double cost;
  double? discount;
  Brand brand;
  List<Category> categories;
  double? sold;

  Product(
    this.idProduct,
    this.name,
    this.image,
    this.description,
    this.cost,
    this.discount,
    this.brand,
    this.categories,
    this.sold,
  );

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

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
