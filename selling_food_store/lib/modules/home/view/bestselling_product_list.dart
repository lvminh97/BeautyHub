import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/modules/home/bloc/home_bloc.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/app_utils.dart';
import '../bloc/home_state.dart';

class BestSellingProductList extends StatelessWidget {
  const BestSellingProductList({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width * 0.45;
    List<Product> productList = [];
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is DisplayProductListState) {
        productList = state.bestSellingProductList;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'bestSellingProduct'.tr(),
                style: const TextStyle(
                  fontSize: 18.0,
                  color: AppColor.sologanColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                productList.length,
                (index) => Container(
                  width: baseWidth,
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                        width: baseWidth,
                        height: 220.0,
                        imageUrl: productList[index].image,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error, color: AppColor.hintGreyColor),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        productList[index].name,
                        maxLines: 2,
                        style: const TextStyle(
                          color: AppColor.blackColor,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        AppUtils.formatPrice(productList[index].getPrice()),
                        maxLines: 1,
                        style: const TextStyle(
                          color: AppColor.priceProductColor,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      MaterialButton(
                        onPressed: () {},
                        elevation: 0.0,
                        minWidth: baseWidth,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        color: AppColor.buttonBuyColor,
                        child: Text(
                          'textbuyNow'.tr(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      RatingBar.builder(
                          itemCount: 5,
                          initialRating: 3,
                          allowHalfRating: true,
                          itemSize: 16.0,
                          itemBuilder: ((context, index) => const Icon(
                                Icons.star,
                                color: AppColor.starColor,
                              )),
                          onRatingUpdate: (value) {}),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
