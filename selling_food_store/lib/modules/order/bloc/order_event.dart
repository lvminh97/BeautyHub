import 'package:paypal_api/models/models.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/models/order_item.dart';

abstract class OrderEvent {}

class OnLoadingRequestOrderEvent extends OrderEvent {
  List<Cart> cartList;
  bool isBuyNow;

  OnLoadingRequestOrderEvent(this.cartList, this.isBuyNow);
}

class OnLoadingUserInfoEvent extends OrderEvent {}

//Event Hien thi thong tin nguoi dat hang
class OnDisplayUserInfoEvent extends OrderEvent {
  String name;
  String address;

  OnDisplayUserInfoEvent(this.name, this.address);
}

//Event Hien thi thong tin cac sp trong gio hang
class OnDisplayRequestOrderEvent extends OrderEvent {
  List<Cart> cartList;

  OnDisplayRequestOrderEvent(this.cartList);
}

class OnDisplayTotalPriceEvent extends OrderEvent {
  double value;

  OnDisplayTotalPriceEvent(this.value);
}

//Event tao order
class OnRequestOrderProductEvent extends OrderEvent {
  List<Cart> cartList;
  String? note;

  OnRequestOrderProductEvent(this.cartList, this.note);
}

class OnChoosePaymentMethodEvent extends OrderEvent {
  int value;

  OnChoosePaymentMethodEvent(this.value);
}

class OnRequestOrderProductFailureEvent extends OrderEvent {
  String error;

  OnRequestOrderProductFailureEvent(this.error);
}

class OnUpdateNumberProductEvent extends OrderEvent {
  double value;

  OnUpdateNumberProductEvent(this.value);
}

class OnCalculateTotalPriceEvent extends OrderEvent {
  double value;

  OnCalculateTotalPriceEvent(this.value);
}

class OnAddProductToOrderInfoEvent extends OrderEvent {
  Item item;
  OrderItem orderItem;

  OnAddProductToOrderInfoEvent(this.item, this.orderItem);
}

class OnAddTrackingOrderEvent extends OrderEvent {
  String idInvoice;

  OnAddTrackingOrderEvent(this.idInvoice);
}

class OnConfirmOrderEvent extends OrderEvent {}
