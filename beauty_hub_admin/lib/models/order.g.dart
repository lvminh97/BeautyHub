// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      json['orderId'] as String,
      json['userID'] as String,
      (json['orderItems'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      DateTime.parse(json['orderDate'] as String),
      json['status'] as String,
      json['reasonCancelOrder'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderId': instance.idOrder,
      'userID': instance.userID,
      'orderItems': instance.orderItems,
      'orderDate': instance.orderDate.toIso8601String(),
      'status': instance.status,
      'reasonCancelOrder': instance.reasonCancelOrder,
    };
