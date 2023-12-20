import 'package:json_annotation/json_annotation.dart';
import 'package:selling_food_store/models/order_item.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  String orderId;
  String userID;
  DateTime orderDate;
  String status;
  List<OrderItem> orderItems;
  String? cancelReason;

  Order(
    this.orderId,
    this.userID,
    this.orderDate,
    this.status,
    this.orderItems,
  );

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Map<String, dynamic> convertToJson() {
    return {
      "orderId": orderId,
      "userID": userID,
      "orderDate": orderDate.toIso8601String(),
      "status": status,
      "orderItems": orderItems.map((e) => e.toJson()).toList(),
      "cancelReason": cancelReason,
    };
  }

  double getTotalPrice() {
    return 0;
    //orderPrice + shippingFee;
  }

  void updateStatusRequestOrder(int value) {
    //status = value;
  }
}
