import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_state.dart';
import 'package:selling_food_store/modules/cart/bloc/item_cart_bloc.dart';
import 'package:selling_food_store/modules/home/bloc/home_bloc.dart';
import 'package:selling_food_store/modules/home/bloc/home_event.dart';

import '../../../models/cart.dart';
import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/app_utils.dart';
import '../../../shared/utils/strings.dart';
import '../bloc/cart_event.dart';

class BottomCartPanel extends StatelessWidget {
  final List<Cart> cartList;
  final Function() onConfirmDelete;

  const BottomCartPanel({
    super.key,
    required this.cartList,
    required this.onConfirmDelete,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    bool isVisibleTotalPricePanel = true;
    return BlocBuilder<ItemCartBloc, CartState>(builder: (context, state) {
      if (state is DisplayTotalPriceState) {
        totalPrice = state.value;
      } else if (state is ConfirmDeleteCartState) {
        isVisibleTotalPricePanel = false;
        context.read<HomeBloc>().add(OnConfirmRemoveItemCartEvent());
      } else if (state is OnDeleteCartState) {
        isVisibleTotalPricePanel = !state.value;
      } else if (state is CancelDeleteCartState) {
        isVisibleTotalPricePanel = true;
        totalPrice = state.value;
      }
      return isVisibleTotalPricePanel
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'titleTotalPrice'.tr(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '${AppUtils.formatPrice(totalPrice)} ${Strings.unitPrice}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      context.goNamed('requestOrder', extra: {
                        "cartList": cartList,
                        "isBuyNow": false,
                      });
                    },
                    color: Colors.green,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'payment'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            )
          : _buildBottomDelete(onCancel: () {
              context.read<ItemCartBloc>().add(OnCancelDeleteCart(totalPrice));
            }, onConfirm: () {
              onConfirmDelete();
            });
    });
  }

  Widget _buildBottomDelete({
    required Function() onCancel,
    required Function() onConfirm,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: MaterialButton(
            onPressed: () {
              onCancel();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            color: AppColor.shimer200Color,
            elevation: 0.0,
            child: Text(
              'cancelDeleteCartText'.tr(),
              style: const TextStyle(
                color: AppColor.blackColor,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: MaterialButton(
            onPressed: () {
              onConfirm();
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            elevation: 0.0,
            color: Colors.redAccent,
            child: Text(
              'confirmDeleteCartText'.tr(),
              style: const TextStyle(
                color: AppColor.whiteColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
