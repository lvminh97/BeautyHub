import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:selling_food_store/models/category.dart';
import 'package:selling_food_store/modules/home/bloc/home_event.dart';
import 'package:selling_food_store/modules/home/bloc/home_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:uuid/uuid.dart';

import '../../../models/cart.dart';
import '../../../models/product.dart';
import '../../../shared/utils/strings.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Product> productList = [];

  HomeBloc() : super(InitHomeState()) {
    if (!isClosed) {
      on<OnLoadingProductList>(_onLoadingProductList);
      on<OnDisplayProductList>(_onDisplayProductList);
      on<OnBuyNowEvent>(_onBuyNowProduct);
      on<OnAddProductToCartEvent>(_onAddProductToCart);
      on<OnRequestSignInEvent>(_onRequestSignIn);
      on<OnBottomSheetCloseEvent>(_onBottomSheetClose);
      on<OnCloseDialogEvent>(_onDialogClose);
      on<OnTabItemClickedEvent>(_onTabItemClicked);
      on<OnReloadProductListEvent>(_onReloadProductListWithType);
      on<OnConfirmAddProductToCartEvent>(_onConfirmAddProductToCart);
      on<OnConfirmRemoveItemCartEvent>(_onConfirmRemoveItemCart);
    }
  }

  Future<void> _onLoadingProductList(
      OnLoadingProductList event, Emitter<HomeState> emitter) async {
    List<Product> recommendProductList = [];
    List<Product> hotSellingProductList = [];
    List<Product> bestSellingProductList = [];
    List<Product> productListWithCategory = [];
    List<Category> typeProducts = [];

    productList = await FirebaseService.fetchProducts();
    typeProducts = await FirebaseService.fetchDataCategories();
    if (productList.isNotEmpty && typeProducts.isNotEmpty) {
      recommendProductList =
          productList.where((e) => e.sold == null || e.sold == 0.0).toList();
      hotSellingProductList =
          productList.where((e) => e.sold != null && e.sold! > 500).toList();
      productListWithCategory = _filterProductListWithType(Strings.typeProduct);
      bestSellingProductList = productList
          .where((e) =>
              e.sold != null &&
              e.sold! > 500 &&
              _filterCategoryListWithType(e.categories, Strings.category))
          .toList();
      add(OnDisplayProductList(recommendProductList, hotSellingProductList,
          bestSellingProductList, typeProducts, productListWithCategory));
    }
  }

  void _onDisplayProductList(
      OnDisplayProductList event, Emitter<HomeState> emitter) {
    emitter(DisplayProductListState(
        event.recommendedProducts,
        event.hotSellingProducts,
        event.bestSellingProducts,
        event.productList,
        event.categories));
  }

  void _onBuyNowProduct(OnBuyNowEvent event, Emitter<HomeState> emitter) {
    if (FirebaseService.checkUserIsSignIn()) {
      List<Cart> cartList = [];
      String idCart = const Uuid().v1();
      Cart cart = Cart(idCart, event.product.idProduct, 1, DateTime.now());
      cartList.add(cart);
      emitter(BuyNowState(cartList));
    } else {
      add(OnRequestSignInEvent());
    }
  }

  void _onAddProductToCart(
      OnAddProductToCartEvent event, Emitter<HomeState> emitter) {
    if (FirebaseService.checkUserIsSignIn()) {
      emitter(AddProductToCartState(event.product));
    } else {
      add(OnRequestSignInEvent());
    }
  }

  void _onConfirmAddProductToCart(
      OnConfirmAddProductToCartEvent event, Emitter<HomeState> emitter) {
    emitter(ConfirmAddProductToCartState());
  }

  void _onConfirmRemoveItemCart(
      OnConfirmRemoveItemCartEvent event, Emitter<HomeState> emitter) {
    emitter(ConfirmRemoveItemCartState());
  }

  void _onRequestSignIn(
      OnRequestSignInEvent event, Emitter<HomeState> emitter) {
    emitter(RequestSignInState());
  }

  void _onBottomSheetClose(
      OnBottomSheetCloseEvent event, Emitter<HomeState> emitter) {
    emitter(BottomSheetCloseState());
  }

  void _onDialogClose(OnCloseDialogEvent event, Emitter<HomeState> emitter) {
    emitter(DialogCloseState());
  }

  void _onTabItemClicked(
      OnTabItemClickedEvent event, Emitter<HomeState> emitter) {
    log('Size product list: ${productList.length}');
    List<Product> products = _filterProductListWithType(event.content);
    add(OnReloadProductListEvent(products));
  }

  void _onReloadProductListWithType(
      OnReloadProductListEvent event, Emitter<HomeState> emitter) {
    emitter(ReloadProductListState(event.productList));
  }

  List<Product> _filterProductListWithType(String type) {
    return productList
        .where((element) =>
            element.categories.where((e) => e.name == type).isNotEmpty)
        .toList();
  }

  bool _filterCategoryListWithType(List<Category> categories, String type) {
    return categories.where((e) => !e.name.contains(type)).isNotEmpty;
  }
}
