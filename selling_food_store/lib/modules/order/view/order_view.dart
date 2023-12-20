import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/modules/order/bloc/order_bloc.dart';
import 'package:selling_food_store/modules/order/bloc/order_event.dart';
import 'package:selling_food_store/modules/order/bloc/order_state.dart';
import 'package:selling_food_store/modules/order/view/bottom_panel.dart';
import 'package:selling_food_store/modules/order/view/choose_payment_method.dart';
import 'package:selling_food_store/modules/order/view/display_price.dart';

import '../../../shared/utils/app_color.dart';
import 'cart_order_info.dart';
import 'user_info_widget.dart';

class RequestOrderView extends StatefulWidget {
  const RequestOrderView({super.key});

  @override
  State<RequestOrderView> createState() => _RequestOrderViewState();
}

class _RequestOrderViewState extends State<RequestOrderView> {
  List<Cart> cartList = [];
  double orderPrice = 0;
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      builder: ((context, state) {
        if (state is DisplayProductForRequestOrderState) {
          cartList = state.cartList;
        }
        return Scaffold(
          backgroundColor: AppColor.whiteColor,
          appBar: AppBar(
            backgroundColor: AppColor.whiteColor,
            elevation: 1.0,
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColor.blackColor,
                )),
            title: Text(
              'detailRequestOrder'.tr(),
              style: const TextStyle(
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const UserInfoWidget(),
                Container(
                  color: AppColor.dividerColor,
                  height: 12.0,
                ),
                CartOrderInfo(carts: cartList),
                Container(
                  color: AppColor.dividerColor,
                  height: 12.0,
                ),
                DisplayPrice(order: orderPrice, total: totalPrice),
                Container(
                  color: AppColor.dividerColor,
                  height: 12.0,
                ),
                const ChoosePaymentMethod(),
              ],
            ),
          ),
          persistentFooterButtons: [
            BottomPanel(
              onOrder: () {
                context
                    .read<OrderBloc>()
                    .add(OnRequestOrderProductEvent(cartList, null));
              },
            )
          ],
        );
      }),
      listener: (context, state) {
        if (state is RequestOrderProductFailureState) {
          EasyLoading.showError(state.message);
        } else if (state is ChoosePaymentMethodState) {
          log('Payment method is ${state.value}');
        } else if (state is AddTrackingOrderState) {
          context.goNamed('trackingOrder', extra: {
            'trackingId': state.idInvoice,
            'idAccount': state.idAccount,
          });
        } else if (state is ConfirmOrderState) {
          context.goNamed('confirmOrder');
        }
      },
    );
  }
}
