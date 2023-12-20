// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      json['productId'] as String,
      json['quantity'] as int,
      (json['pricePerItem'] as num).toDouble(),
      json['brandId'] as String,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
      'pricePerItem': instance.pricePerItem,
      'brandId': instance.brandId,
    };
