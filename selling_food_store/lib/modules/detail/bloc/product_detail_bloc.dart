import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/models/review.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:uuid/uuid.dart';

import '../../../models/product.dart';
import '../../../models/product_detail.dart';

part 'product_detail_state.dart';
part 'product_detail_event.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(LoadingProductDetailState()) {
    on<LoadingProductDetailEvent>(_onLoading);
    on<DisplayProductDetailEvent>(_onDisplay);
    on<OnAddProductToCartEvent>(_onAddProductToCart);
    on<OnBuyNowEvent>(_onBuyNow);
    on<OnFailureEvent>(_onBuyNowFailure);
    on<OnRequestSignInEvent>(_onRequestSignIn);
    on<OnBottomSheetCloseEvent>(_onBottomSheetClose);
    on<OnDialogCloseEvent>(_onDialogClose);
  }

  Future<void> _onLoading(LoadingProductDetailEvent event,
      Emitter<ProductDetailState> emitter) async {
    final detailProduct = await FirebaseService.fetchDataProductDetail(
        event.idProduct, (error) => add(OnFailureEvent(error)));
    List<Review> reviews =
        await FirebaseService.getReviewsForProduct(event.idProduct);
    if (detailProduct != null) {
      add(DisplayProductDetailEvent(detailProduct, reviews));
    }
  }

  void _onDisplay(
      DisplayProductDetailEvent event, Emitter<ProductDetailState> emitter) {
    emitter(DisplayProductDetailState(productDetail: event.detail, reviews: event.reviews));
  }

  void _onAddProductToCart(
      OnAddProductToCartEvent event, Emitter<ProductDetailState> emitter) {
    if (FirebaseService.checkUserIsSignIn()) {
      emitter(AddProductToCartState(event.product));
    } else {
      add(OnRequestSignInEvent());
    }
  }

  void _onBuyNow(OnBuyNowEvent event, Emitter<ProductDetailState> emitter) {
    if (FirebaseService.checkUserIsSignIn()) {
      List<Cart> cartList = [];
      String idCart = const Uuid().v1();
      Cart cart = Cart(idCart, event.product.idProduct, 1, DateTime.now());
      cartList.add(cart);
      emitter(BuyNowSuccessState(cartList));
    } else {
      add(OnRequestSignInEvent());
    }
  }

  void _onBuyNowFailure(
      OnFailureEvent event, Emitter<ProductDetailState> emitter) {
    emitter(BuyNowFailureState(event.error));
  }

  void _onRequestSignIn(
      OnRequestSignInEvent event, Emitter<ProductDetailState> emitter) {
    emitter(RequestSignInState());
  }

  void _onBottomSheetClose(
      OnBottomSheetCloseEvent event, Emitter<ProductDetailState> emitter) {
    emitter(BottomSheetCloseState());
  }

  void _onDialogClose(
      OnDialogCloseEvent event, Emitter<ProductDetailState> emitter) {
    emitter(DialogCloseState());
  }
}
