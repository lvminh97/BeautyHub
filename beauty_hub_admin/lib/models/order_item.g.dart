// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      json['brandId'] as String,
      (json['pricePerItem'] as num).toDouble(),
      json['productId'] as String,
      json['quantity'] as int,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'brandId': instance.brandId,
      'pricePerItem': instance.pricePerItem,
      'productId': instance.productId,
      'quantity': instance.quantity,
    };
