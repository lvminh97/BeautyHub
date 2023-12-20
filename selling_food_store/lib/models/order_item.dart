import 'package:json_annotation/json_annotation.dart';

part 'order_item.g.dart';

@JsonSerializable()
class OrderItem {
  String productId;
  int quantity;
  double pricePerItem;
  String brandId;

  OrderItem(
    this.productId,
    this.quantity,
    this.pricePerItem,
    this.brandId,
  );

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
