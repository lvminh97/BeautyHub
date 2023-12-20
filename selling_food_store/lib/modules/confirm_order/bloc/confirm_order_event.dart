import '../../../models/product.dart';

abstract class ConfirmOrderEvent {}

class OnInitConfirmOrderEvent extends ConfirmOrderEvent {}

class OnDisplayProductListEvent extends ConfirmOrderEvent {
  final List<Product> productList;

  OnDisplayProductListEvent(this.productList);
}
