part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent {
  ProductDetailEvent();
}

class LoadingProductDetailEvent extends ProductDetailEvent {
  String idProduct;

  LoadingProductDetailEvent(this.idProduct);
}

class DisplayProductDetailEvent extends ProductDetailEvent {
  ProductDetail detail;
  List<Review> reviews;

  DisplayProductDetailEvent(this.detail, this.reviews);
}

class OnAddProductToCartEvent extends ProductDetailEvent {
  Product product;
  int quantity;

  OnAddProductToCartEvent(this.product, this.quantity);
}

class OnBuyNowEvent extends ProductDetailEvent {
  Product product;
  int quantity;

  OnBuyNowEvent(this.product, this.quantity);
}

class OnBuyNowSuccessEvent extends ProductDetailEvent {}

class OnFailureEvent extends ProductDetailEvent {
  String error;

  OnFailureEvent(this.error);
}

class OnRequestSignInEvent extends ProductDetailEvent {}

class OnBottomSheetCloseEvent extends ProductDetailEvent {}

class OnDialogCloseEvent extends ProductDetailEvent {}
