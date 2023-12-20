import 'package:equatable/equatable.dart';
import 'package:selling_food_store/models/cart.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitRequestOrderState extends OrderState {}

class UpdateNumberProductState extends OrderState {
  final double price;

  UpdateNumberProductState(this.price);

  @override
  List<Object?> get props => [price];
}

class DisplayProductForRequestOrderState extends OrderState {
  final List<Cart> cartList;

  DisplayProductForRequestOrderState(this.cartList);

  @override
  List<Object?> get props => [cartList];
}

class DisplayTotalPriceState extends OrderState {
  final double value;

  DisplayTotalPriceState(this.value);

  @override
  List<Object?> get props => [value];
}

class DisplayUserInfoState extends OrderState {
  final String name;
  final String address;

  DisplayUserInfoState(this.name, this.address);

  @override
  List<Object?> get props => [name, address];
}

class RequestOrderProductFailureState extends OrderState {
  final String message;

  RequestOrderProductFailureState(this.message);
}

class ChoosePaymentMethodState extends OrderState {
  final int value;

  ChoosePaymentMethodState(this.value);

  @override
  List<Object?> get props => [value];
}

class AddTrackingOrderState extends OrderState {
  final String idInvoice;
  final String idAccount;

  AddTrackingOrderState(
    this.idInvoice,
    this.idAccount,
  );

  @override
  List<Object?> get props => [idInvoice, idAccount];
}

class ConfirmOrderState extends OrderState {}
