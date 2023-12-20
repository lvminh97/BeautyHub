import 'package:equatable/equatable.dart';
import 'package:paypal_api/models/models.dart';

import '../../../models/product.dart';

abstract class ConfirmOrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitConfirmOrderState extends ConfirmOrderState {}

class DisplayProductListState extends ConfirmOrderState {
  final List<Product> productList;

  DisplayProductListState(this.productList);

  @override
  List<Object?> get props => [productList];
}

class GetInvoiceDetailState extends ConfirmOrderState {
  final InvoiceDetail detail;

  GetInvoiceDetailState(this.detail);

  @override
  List<Object?> get props => [detail];
}
