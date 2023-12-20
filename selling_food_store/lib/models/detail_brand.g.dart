// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailBrand _$DetailBrandFromJson(Map<String, dynamic> json) => DetailBrand(
      json['idBrand'] as String,
      json['name'] as String,
      json['logo'] as String,
      json['address'] as String,
      json['desc'] as String?,
      (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DetailBrandToJson(DetailBrand instance) =>
    <String, dynamic>{
      'idBrand': instance.idBrand,
      'name': instance.name,
      'logo': instance.logo,
      'address': instance.address,
      'desc': instance.desc,
      'products': instance.products,
    };
