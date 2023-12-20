// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) =>
    ProductDetail(
      json['idProduct'] as String,
      json['name'] as String,
      json['image'] as String,
      json['description'] as String,
      (json['cost'] as num).toDouble(),
      (json['discount'] as num?)?.toDouble(),
      json['introduce'] as String?,
      (json['ingredients'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['uses'] as List<dynamic>).map((e) => e as String).toList(),
      (json['howToUse'] as List<dynamic>).map((e) => e as String).toList(),
      json['origin'] as String,
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      Brand.fromJson(json['brand'] as Map<String, dynamic>),
      (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['sold'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      'idProduct': instance.idProduct,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'cost': instance.cost,
      'discount': instance.discount,
      'introduce': instance.introduce,
      'ingredients': instance.ingredients,
      'uses': instance.uses,
      'howToUse': instance.howToUse,
      'origin': instance.origin,
      'tags': instance.tags,
      'brand': instance.brand,
      'categories': instance.categories,
      'sold': instance.sold,
    };
