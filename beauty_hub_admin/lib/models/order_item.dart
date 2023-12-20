import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {
  String brandId;
  double pricePerItem;
  String productId;
  int quantity;

  OrderItem(
    this.brandId,
    this.pricePerItem,
    this.productId,
    this.quantity,
  );

  factory OrderItem.fromJson(Map<String, dynamic> json) => _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
