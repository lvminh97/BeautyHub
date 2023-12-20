import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../models/cart.dart';

@immutable
abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingCartListState extends CartState {}

class DisplayNotSignInState extends CartState {}

class DisplayCartListState extends CartState {
  final List<Cart> cartList;

  DisplayCartListState({required this.cartList});

  @override
  List<Object?> get props => [cartList];
}

class DisplayTotalPriceState extends CartState {
  final double value;

  DisplayTotalPriceState({required this.value});

  @override
  List<Object?> get props => [value];
}

class OnInitQuantityState extends CartState {
  OnInitQuantityState();

  @override
  List<Object?> get props => [];
}

class OnDeleteCartState extends CartState {
  final bool value;

  OnDeleteCartState(this.value);

  @override
  List<Object?> get props => [value];
}

class ConfirmDeleteCartState extends CartState {}

class CancelDeleteCartState extends CartState {
  final double value;

  CancelDeleteCartState(this.value);

  @override
  List<Object?> get props => [value];
}
