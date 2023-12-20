import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/confirm_order/bloc/confirm_order_event.dart';
import 'package:selling_food_store/modules/confirm_order/bloc/confirm_order_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';

import '../../../models/product.dart';

class ConfirmOrderBloc extends Bloc<ConfirmOrderEvent, ConfirmOrderState> {
  ConfirmOrderBloc() : super(InitConfirmOrderState()) {
    on<OnInitConfirmOrderEvent>(_onInit);
    on<OnDisplayProductListEvent>(_onDisplay);
  }

  Future<void> _onInit(
      OnInitConfirmOrderEvent event, Emitter<ConfirmOrderState> emitter) async {
    List<Product> products = await FirebaseService.fetchProducts();
    add(OnDisplayProductListEvent(products));
  }

  void _onDisplay(
      OnDisplayProductListEvent event, Emitter<ConfirmOrderState> emitter) {
    emitter(DisplayProductListState(event.productList));
  }
}
