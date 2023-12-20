import 'package:paypal_api/models/models.dart';
import 'package:selling_food_store/models/order_item.dart';

abstract class TrackingOrderEvent {}

class OnInitTrackingOrderEvent extends TrackingOrderEvent {
  final String id;

  OnInitTrackingOrderEvent(this.id);
}

class OnGetInvoiceDetailEvent extends TrackingOrderEvent {
  final InvoiceDetail detailInvoice;

  OnGetInvoiceDetailEvent(this.detailInvoice);
}

class OnPaymentEvent extends TrackingOrderEvent {
  final String id;
  OnPaymentEvent(this.id);
}

class OnConfirmCancelPaymentEvent extends TrackingOrderEvent {}

class OnCancelPaymentEvent extends TrackingOrderEvent {}

class OnAddProductToTrackingOrderEvent extends TrackingOrderEvent {
  final OrderItem orderItem;

  OnAddProductToTrackingOrderEvent(this.orderItem);
}
