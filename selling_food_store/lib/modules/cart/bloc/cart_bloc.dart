import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_event.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/services/hive_service.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(LoadingCartListState()) {
    on<LoadingCartListEvent>(_getCartList);
    on<DisplayCartListEvent>(_onDisplayCartList);
    on<OnDisplayNotSignInEvent>(_onDisplayUINotSignIn);
  }

  void _getCartList(LoadingCartListEvent event, Emitter<CartState> emitter) {
    if (FirebaseService.checkUserIsSignIn()) {
      List<Cart> dataList = HiveService.getCartList();
      log('Size Cart: ${dataList.length}');
      if (dataList.isNotEmpty) {
        add(DisplayCartListEvent(dataList));
      } else {
        FirebaseService.fetchProductListToCart((carts) {
          if(carts.isEmpty) {
            
          }
          HiveService.addAllCartList(carts);
          add(DisplayCartListEvent(carts));
        }, (error) {
          add(DisplayCartListEvent([]));
        });
      }
    } else {
      add(OnDisplayNotSignInEvent());
    }
  }

  void _onDisplayCartList(
      DisplayCartListEvent event, Emitter<CartState> emitter) {
    emitter(DisplayCartListState(cartList: event.cartList));
  }

  void _onDisplayUINotSignIn(
      OnDisplayNotSignInEvent event, Emitter<CartState> emitter) {
    emitter(DisplayNotSignInState());
  }
}
