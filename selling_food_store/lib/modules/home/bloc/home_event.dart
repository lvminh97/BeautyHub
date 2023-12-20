import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/models/category.dart';

abstract class HomeEvent {
  HomeEvent();
}

class OnLoadingProductList extends HomeEvent {}

class OnDisplayProductList extends HomeEvent {
  List<Product> recommendedProducts;
  List<Product> hotSellingProducts;
  List<Product> bestSellingProducts;
  List<Category> categories;
  List<Product> productList;

  OnDisplayProductList(
    this.recommendedProducts,
    this.hotSellingProducts,
    this.bestSellingProducts,
    this.categories,
    this.productList,
  );
}

class OnBuyNowEvent extends HomeEvent {
  Product product;

  OnBuyNowEvent(this.product);
}

class OnAddProductToCartEvent extends HomeEvent {
  Product product;

  OnAddProductToCartEvent(this.product);
}

class OnConfirmAddProductToCartEvent extends HomeEvent {}

class OnConfirmRemoveItemCartEvent extends HomeEvent {}

class OnTabItemClickedEvent extends HomeEvent {
  String content;

  OnTabItemClickedEvent(this.content);
}

class OnReloadProductListEvent extends HomeEvent {
  List<Product> productList;

  OnReloadProductListEvent(this.productList);
}

class OnRequestSignInEvent extends HomeEvent {}

class OnBottomSheetCloseEvent extends HomeEvent {}

class OnCloseDialogEvent extends HomeEvent {}

class OnInitProductListWithTypeEvent extends HomeEvent {
  List<Product> products;

  OnInitProductListWithTypeEvent(this.products);
}
