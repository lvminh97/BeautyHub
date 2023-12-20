import 'package:equatable/equatable.dart';
import 'package:selling_food_store/models/order.dart';

abstract class OrderListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingOrderListState extends OrderListState {}

class DisplayOrderListState extends OrderListState {
  final List<Order> allOrders;
  final List<Order> requestOrders;
  final List<Order> confirmOrders;
  final List<Order> successOrders;
  final List<Order> cancelOrders;

  DisplayOrderListState(
    this.allOrders,
    this.requestOrders,
    this.confirmOrders,
    this.successOrders,
    this.cancelOrders,
  );

  @override
  List<Object?> get props => [
        allOrders,
        requestOrders,
        confirmOrders,
        successOrders,
        cancelOrders,
      ];
}

class CancelOrderState extends OrderListState {
  final String id;

  CancelOrderState(this.id);

  @override
  List<Object?> get props => [id];
}

class ConfirmCancelOrderState extends OrderListState {}

class CloseBottomSheetState extends OrderListState {}

class FeedbackProductState extends OrderListState {}

class ErrorCancelOrderState extends OrderListState {
  final String error;

  ErrorCancelOrderState(this.error);

  @override
  List<Object?> get props => [error];
}
