import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/order/bloc/order_event.dart';
import 'package:selling_food_store/modules/order/bloc/order_state.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';

class UpdateNumberProductBloc extends Bloc<OrderEvent, OrderState> {
  double totalPrice = 0;
  List<double> prices = [];

  UpdateNumberProductBloc() : super(InitRequestOrderState()) {
    on<OnUpdateNumberProductEvent>(_onUpdateNumberProductEvent);
    on<OnCalculateTotalPriceEvent>(_onCalculateTotalPrice);
    on<OnDisplayTotalPriceEvent>(_onDisplayTotalPrice);
  }

  void _onCalculateTotalPrice(
      OnCalculateTotalPriceEvent event, Emitter<OrderState> emitter) {
    prices.add(event.value);
    totalPrice = AppUtils.calculateTotalPrice(prices);
    add(OnDisplayTotalPriceEvent(totalPrice));
  }

  void _onDisplayTotalPrice(
      OnDisplayTotalPriceEvent event, Emitter<OrderState> emitter) {
    emitter(DisplayTotalPriceState(event.value));
  }

  void _onUpdateNumberProductEvent(
      OnUpdateNumberProductEvent event, Emitter<OrderState> emitter) {
    totalPrice = totalPrice + event.value;
    emitter(UpdateNumberProductState(totalPrice));
  }
}
