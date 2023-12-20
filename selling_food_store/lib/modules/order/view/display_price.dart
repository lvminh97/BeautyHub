import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/order/bloc/order_state.dart';
import 'package:selling_food_store/modules/order/bloc/update_number_product_bloc.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/app_utils.dart';
import '../../../shared/utils/strings.dart';

class DisplayPrice extends StatelessWidget {
  final double order;
  final double total;

  const DisplayPrice({
    super.key,
    required this.order,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    double orderPrice = order;
    double totalPrice = total;
    return BlocBuilder<UpdateNumberProductBloc, OrderState>(
        builder: (context, state) {
      if (state is DisplayTotalPriceState) {
        orderPrice = state.value;
        totalPrice = orderPrice + 20000;
      } else if (state is UpdateNumberProductState) {
        orderPrice = state.price;
        totalPrice = orderPrice + 20000;
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'requestOrder'.tr(),
              style: const TextStyle(
                fontSize: 16.0,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'totalProductPrice'.tr(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '${AppUtils.formatPrice(orderPrice)}đ',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'shippingFee'.tr(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  AppUtils.formatPrice(Strings.shippingFeeValue),
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'totalPrice'.tr(),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${AppUtils.formatPrice(totalPrice)}đ',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
