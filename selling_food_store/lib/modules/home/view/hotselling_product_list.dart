import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/home/bloc/home_bloc.dart';
import 'package:selling_food_store/modules/home/bloc/home_event.dart';
import 'package:selling_food_store/modules/home/bloc/home_state.dart';
import 'package:selling_food_store/shared/widgets/general/empty_data_widget.dart';
import 'package:selling_food_store/shared/widgets/general/loading_data_widget.dart';

import '../../../models/product.dart';
import '../../../shared/utils/app_color.dart';
import '../../../shared/widgets/items/item_best_selling.dart';

class HotSellingProductList extends StatefulWidget {
  const HotSellingProductList({super.key});

  @override
  State<HotSellingProductList> createState() => _HotSellingProductListState();
}

class _HotSellingProductListState extends State<HotSellingProductList> {
  List<Product> productList = [];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(builder: (context, state) {
      return isLoading
          ? const LoadingDataWidget(
              loadingType: LoadingDataType.loadingHotSellingProductList)
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
                          'titleHotCosmetics'.tr(),
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: AppColor.sologanColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 450.0,
                      child: ListView.builder(
                          itemCount: productList.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ItemBestSelling(
                                onClick: () {
                                  context.goNamed('productDetail',
                                      extra: productList[index]);
                                },
                                product: productList[index],
                                onBuyNow: (data) {
                                  context
                                      .read<HomeBloc>()
                                      .add(OnBuyNowEvent(data));
                                },
                              )),
                    ),
                  ],
                )
              : const EmptyDataWidget(emptyType: EmptyType.productListEmpty);
    }, listener: (context, state) {
      if (state is InitHomeState) {
        isLoading = true;
      } else if (state is DisplayProductListState) {
        isLoading = false;
        productList = state.hotSellingProductList;
      } else if (state is BuyNowState) {
        context.goNamed('requestOrder', extra: {
          "cartList": state.cartList,
          "isBuyNow": true,
        });
      }
    });
  }
}
