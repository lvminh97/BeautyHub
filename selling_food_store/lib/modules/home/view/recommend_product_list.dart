import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/modules/home/bloc/home_bloc.dart';
import 'package:selling_food_store/modules/home/bloc/home_event.dart';
import 'package:selling_food_store/modules/home/bloc/home_state.dart';

import 'package:selling_food_store/shared/widgets/general/empty_data_widget.dart';
import 'package:selling_food_store/shared/widgets/general/loading_data_widget.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/bottomsheet_utils.dart';
import '../../../shared/widgets/items/item_recommend_product.dart';

class RecommendProductList extends StatefulWidget {
  const RecommendProductList({super.key});

  @override
  State<RecommendProductList> createState() => _RecommendProductListState();
}

class _RecommendProductListState extends State<RecommendProductList> {
  List<Product> productList = [];
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        listener: (buildContext, state) {
          if (state is InitHomeState) {
            isLoading = true;
          } else if (state is DisplayProductListState) {
            isLoading = false;
            productList = state.recommendProductList;
          } else if (state is AddProductToCartState) {
            BottomSheetUtils.showBottomSheetAddProductToCart(
                context: context,
                product: state.product,
                onAdd: (productSelected, quantity) {
                  if (productSelected
                      .isProductExistsInCart(productSelected.idProduct)) {
                    EasyLoading.showToast('isProductExistsInCart'.tr());
                  } else {
                    productSelected.addCart(quantity);
                    context
                        .read<HomeBloc>()
                        .add(OnConfirmAddProductToCartEvent());
                  }
                },
                onClose: () {
                  context.read<HomeBloc>().add(OnBottomSheetCloseEvent());
                });
          } else if (state is BuyNowState) {
            context.goNamed('requestOrder', extra: {
              "cartList": state.cartList,
              "isBuyNow": true,
            });
          } else if (state is BottomSheetCloseState) {
            log('bottom sheet is closed');
          }
        },
        builder: ((context, state) => isLoading
            ? const LoadingDataWidget(
                loadingType: LoadingDataType.loadingRecommendProductList)
            : productList.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'titleRecommendedProduct'.tr(),
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: AppColor.sologanColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List.generate(
                                productList.length,
                                (index) => ItemRecommendProduct(
                                      product: productList[index],
                                      onBuy: () {
                                        context.read<HomeBloc>().add(
                                            OnBuyNowEvent(productList[index]));
                                      },
                                      onClick: () {
                                        context.goNamed('productDetail',
                                            extra: productList[index]);
                                      },
                                      onAddCart: (Product product) {
                                        context.read<HomeBloc>().add(
                                            OnAddProductToCartEvent(product));
                                      },
                                    )),
                          ),
                        )
                      ])
                : const EmptyDataWidget(
                    emptyType: EmptyType.productListEmpty)));
  }
}
