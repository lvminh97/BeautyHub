// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      json['orderId'] as String,
      json['userID'] as String,
      DateTime.parse(json['orderDate'] as String),
      json['status'] as String,
      (json['orderItems'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..cancelReason = json['cancelReason'] as String?;

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'orderId': instance.orderId,
      'userID': instance.userID,
      'orderDate': instance.orderDate.toIso8601String(),
      'status': instance.status,
      'orderItems': instance.orderItems,
      'cancelReason': instance.cancelReason,
    };
