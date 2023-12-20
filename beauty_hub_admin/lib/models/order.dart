import 'package:beauty_hub_admin/models/order_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: 'orderId')
  String idOrder;
  String userID;
  List<OrderItem> orderItems;
  DateTime orderDate;
  String status;
  String? reasonCancelOrder;

  Order(
    this.idOrder,
    this.userID,
    this.orderItems,
    this.orderDate,
    this.status,
    this.reasonCancelOrder,
  );

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  Map<String, dynamic> convertToJson() {
    return {
      "orderId": idOrder,
      'userID': userID,
      "orderItems": orderItems.map((e) => e.toJson()).toList(),
      "orderDate": orderDate.toIso8601String(),
      "status": status,
      "reasonCancelOrder": reasonCancelOrder,
    };
  }
}
