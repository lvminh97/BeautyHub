import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Cart extends HiveObject {
  @HiveField(0)
  @JsonKey(name: 'cart_id')
  String cartID;
  @HiveField(1)
  @JsonKey(name: 'product_id')
  String productID;
  @HiveField(2)
  @JsonKey(name: 'quantity')
  int quantity;
   @HiveField(3)
  DateTime dateTime;

  Cart(this.cartID, this.productID, this.quantity, this.dateTime);

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);

  void updateQuantity(int value) {
    quantity = value;
    save();
  }
}
