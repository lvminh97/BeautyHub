import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/models/review.dart';
import 'package:selling_food_store/modules/detail/bloc/product_detail_bloc.dart';
import 'package:selling_food_store/shared/widgets/items/item_feedback.dart';

import '../../../shared/utils/app_color.dart';

class EvaluteProductTabView extends StatelessWidget {
  const EvaluteProductTabView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Review> reviewList = [];
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
      if (state is DisplayProductDetailState) {
        reviewList = state.reviews;
      }
      return Container(
        color: AppColor.whiteColor,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'customerReviews'.tr(),
                    style: const TextStyle(
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                reviewList.isNotEmpty
                    ? Text(
                        'viewMore'.tr(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: 24.0),
            reviewList.isNotEmpty
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(reviewList.length,
                        (index) => ItemFeedback(review: reviewList[index])),
                  )
                : const Center(
                    child: Text('Hãy là người đầu tiên đánh giá sản phẩm này')),
          ],
        ),
      );
    });
  }
}
