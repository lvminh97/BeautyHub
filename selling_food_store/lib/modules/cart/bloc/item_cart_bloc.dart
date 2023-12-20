import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_event.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/services/hive_service.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';

class ItemCartBloc extends Bloc<CartEvent, CartState> {
  double _totalPrice = 0;
  List<double> prices = [];

  ItemCartBloc() : super(OnInitQuantityState()) {
    if (!isClosed) {
      on<OnDisplayTotalPriceEvent>(_onDisplayTotalPrice);
      on<OnDeleteCartEvent>(_onDeleteCart);
      on<OnIncreaseQuantityEvent>(_onIncreaseQuantity);
      on<OnDecreaseQuantityEvent>(_onDecreaseQuantity);
      on<OnConfirmDeleteCart>(_onConfirmDeleteCart);
      on<OnCancelDeleteCart>(_onCancelDeleteCart);
      on<OnCalculateTotalPriceEvent>(_onCalculateTotalPrice);
    }
  }

  void _onCalculateTotalPrice(
      OnCalculateTotalPriceEvent event, Emitter<CartState> emitter) {
    prices.add(event.price);
    _totalPrice = AppUtils.calculateTotalPrice(prices);
    add(OnDisplayTotalPriceEvent(_totalPrice));
  }

  void _onDisplayTotalPrice(
      OnDisplayTotalPriceEvent event, Emitter<CartState> emitter) {
    emitter(DisplayTotalPriceState(value: event.price));
  }

  void _onIncreaseQuantity(
      OnIncreaseQuantityEvent event, Emitter<CartState> emitter) {
    _totalPrice = _totalPrice + event.value;
    add(OnDisplayTotalPriceEvent(_totalPrice));
  }

  void _onDecreaseQuantity(
      OnDecreaseQuantityEvent event, Emitter<CartState> emitter) {
    _totalPrice = _totalPrice - event.value;
    add(OnDisplayTotalPriceEvent(_totalPrice));
  }

  void _onDeleteCart(OnDeleteCartEvent event, Emitter<CartState> emitter) {
    emitter(OnDeleteCartState(event.isDelete));
  }

  void _onConfirmDeleteCart(
      OnConfirmDeleteCart event, Emitter<CartState> emitter) {
    if (event.removeCartList.isEmpty) {
      EasyLoading.showToast('notifyChoosItemCart'.tr());
    } else {
      HiveService.deleteItemCart(event.removeCartList);
      FirebaseService.removeCartList(cartList: event.removeCartList);
      emitter(ConfirmDeleteCartState());
    }
  }

  void _onCancelDeleteCart(
      OnCancelDeleteCart event, Emitter<CartState> emitter) {
    emitter(CancelDeleteCartState(_totalPrice));
  }
}
