import 'package:equatable/equatable.dart';
import 'package:paypal_api/models/invoice_detail.dart';

abstract class TrackingOrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitTrackingOrderState extends TrackingOrderState {}

class GetInvoiceDetailState extends TrackingOrderState {
  final InvoiceDetail detail;

  GetInvoiceDetailState(this.detail);

  @override
  List<Object?> get props => [detail];
}

class PaymentState extends TrackingOrderState {
  final String urlRequest;

  PaymentState(this.urlRequest);

  @override
  List<Object?> get props => [urlRequest];
}

class CancelPaymentState extends TrackingOrderState {}

class ConfirmCancelPaymentState extends TrackingOrderState {}
