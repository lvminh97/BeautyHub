import 'package:selling_food_store/models/cart.dart';

abstract class CartEvent {}

class LoadingCartListEvent extends CartEvent {}

class OnDisplayNotSignInEvent extends CartEvent {}

class DisplayCartListEvent extends CartEvent {
  List<Cart> cartList;

  DisplayCartListEvent(this.cartList);
}

class OnCalculateTotalPriceEvent extends CartEvent {
  double price;

  OnCalculateTotalPriceEvent(this.price);
}

class OnDisplayTotalPriceEvent extends CartEvent {
  double price;

  OnDisplayTotalPriceEvent(this.price);
}

class OnIncreaseQuantityEvent extends CartEvent {
  double value;

  OnIncreaseQuantityEvent(this.value);
}

class OnDecreaseQuantityEvent extends CartEvent {
  double value;

  OnDecreaseQuantityEvent(this.value);
}

class OnDeleteCartEvent extends CartEvent {
  bool isDelete;

  OnDeleteCartEvent(this.isDelete);
}

class OnConfirmDeleteCart extends CartEvent {
  List<Cart> removeCartList;

  OnConfirmDeleteCart(this.removeCartList);
}

class OnCancelDeleteCart extends CartEvent {
  double value;

  OnCancelDeleteCart(this.value);
}