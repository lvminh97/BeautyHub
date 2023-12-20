import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/models/product_detail.dart';
import 'package:selling_food_store/modules/detail/bloc/product_detail_bloc.dart';
import 'package:selling_food_store/modules/detail/view/evalute_product_tab_view.dart';
import 'package:selling_food_store/modules/detail/view/product_detail_tab_view.dart';
import 'package:selling_food_store/modules/detail/view/brand_info.dart';
import 'package:selling_food_store/shared/utils/show_dialog_utils.dart';
import 'package:selling_food_store/shared/widgets/general/general_button.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/bottomsheet_utils.dart';
import '../../../shared/widgets/general/loading_data_widget.dart';
import '../../../shared/widgets/general/price_widget.dart';
import '../../../shared/widgets/general/search_bar.dart' as searchBar;
import '../../home/view/home_view.dart';

class ProductDetailView extends StatefulWidget {
  final Product product;
  const ProductDetailView({super.key, required this.product});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  ProductDetail? productDetail;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        return productDetail != null
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  titleSpacing: 0.0,
                  leading: IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColor.blackColor,
                      )),
                  backgroundColor: AppColor.whiteColor,
                  elevation: 0.0,
                  title: searchBar.SearchBar(
                    hintText: productDetail!.name,
                    onSearch: () {
                      showSearch(
                        context: context,
                        delegate: ProductSearchDelegate(),
                      );
                    },
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          context
                              .read<ProductDetailBloc>()
                              .add(OnAddProductToCartEvent(widget.product, 1));
                        },
                        splashColor: AppColor.transparentColor,
                        hoverColor: AppColor.transparentColor,
                        highlightColor: AppColor.transparentColor,
                        focusColor: AppColor.transparentColor,
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: AppColor.blackColor,
                        ))
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                        width: double.infinity,
                        height: 280.0,
                        imageUrl: productDetail!.image,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error, color: AppColor.hintGreyColor),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          productDetail!.name,
                          style: const TextStyle(
                            fontSize: 22.0,
                            color: AppColor.primaryAppColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.discount,
                              size: 32.0,
                              color: AppColor.starColor,
                            ),
                            const SizedBox(width: 12.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                PriceWidget(
                                  value: productDetail!.getPrice(),
                                  textSize: 18.0,
                                  isUnit: true,
                                  isPrice: true,
                                  unitTextColor: AppColor.priceProductColor,
                                  priceTextColor: AppColor.priceProductColor,
                                  isTextBold: true,
                                ),
                                const SizedBox(height: 4.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    PriceWidget(
                                      value: productDetail!.cost,
                                      textSize: 14.0,
                                      isUnit: true,
                                      unitTextColor: AppColor.hintGreyColor,
                                      priceTextColor: AppColor.hintGreyColor,
                                      isTextBold: false,
                                      width: 50.0,
                                    ),
                                    const SizedBox(width: 4.0),
                                    productDetail!.discount != null
                                        ? Text(
                                            ' - ${productDetail!.discount!.toInt()}%',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColor.hintGreyColor,
                                            ),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          productDetail!.description,
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      ProductDetailTabView(detail: productDetail!),
                      Container(height: 12.0, color: AppColor.divider100Color),
                      const BrandInfo(),
                      Container(
                        margin: const EdgeInsets.only(top: 12.0),
                        color: AppColor.divider100Color,
                        child: const EvaluteProductTabView(),
                      ),
                    ],
                  ),
                ),
                persistentFooterButtons: [
                  GeneralButton(
                      title: 'textbuyNow'.tr(),
                      onClick: () {
                        context
                            .read<ProductDetailBloc>()
                            .add(OnBuyNowEvent(widget.product, 1));
                      }),
                ],
              )
            : const LoadingDataWidget(
                loadingType: LoadingDataType.loadingProductDetail);
      },
      listener: (context, state) {
        if (state is DisplayProductDetailState) {
          productDetail = state.productDetail;
        } else if (state is AddProductToCartState) {
          BottomSheetUtils.showBottomSheetAddProductToCart(
              context: context,
              product: state.product,
              onAdd: (productSelected, quantity) {
                productSelected.addCart(quantity);
                //EasyLoading.showSuccess('addCartSuccess'.tr());
                //context.read<ProductDetailBloc>().add(OnFailureEvent(error));
              },
              onClose: () {
                context
                    .read<ProductDetailBloc>()
                    .add(OnBottomSheetCloseEvent());
              });
        } else if (state is BuyNowSuccessState) {
          context.goNamed('productDetailRequestOrder', extra: {
            "cartList": state.cartList,
            "isBuyNow": true,
          });
        } else if (state is BuyNowFailureState) {
          EasyLoading.showError(state.error);
        } else if (state is RequestSignInState) {
          ShowDialogUtils.showDialogRequestSignIn(context, () {
            context.goNamed('signIn');
          }, () {
            context.read<ProductDetailBloc>().add(OnDialogCloseEvent());
          });
        } else if (state is BottomSheetCloseState) {
          log('Bottom sheet is closed');
        } else if (state is DialogCloseState) {
          log('Dialog is closed');
        }
      },
    );
  }
}
