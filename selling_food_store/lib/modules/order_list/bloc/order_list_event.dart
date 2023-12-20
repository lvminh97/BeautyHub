import 'package:selling_food_store/models/order.dart';

abstract class OrderListEvent {}

class OnLoadingOrderListEvent extends OrderListEvent {}

class OnDisplayOrderListEvent extends OrderListEvent {
  List<Order> allOrders;
  List<Order> requestOrders;
  List<Order> confirmOrders;
  List<Order> successOrders;
  List<Order> cancelOrders;

  OnDisplayOrderListEvent(
    this.allOrders,
    this.requestOrders,
    this.confirmOrders,
    this.successOrders,
    this.cancelOrders,
  );
}

class OnCancelOrderEvent extends OrderListEvent {
  String idOrder;

  OnCancelOrderEvent(this.idOrder);
}

class OnConfirmCancelOrderEvent extends OrderListEvent {
  String idOrder;
  String reason;

  OnConfirmCancelOrderEvent(this.idOrder, this.reason);
}

class OnFeedbackProductEvent extends OrderListEvent {
  double? rating;
  String review;
  String idProduct;

  OnFeedbackProductEvent(
    this.rating,
    this.review,
    this.idProduct,
  );
}

class OnCancelOrderSuccessEvent extends OrderListEvent {}

class OnCloseBottomSheetEvent extends OrderListEvent {}

class OnErrorEvent extends OrderListEvent {
  String error;

  OnErrorEvent(this.error);
}
