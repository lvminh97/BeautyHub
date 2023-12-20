import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_bloc.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_event.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_state.dart';
import 'package:selling_food_store/modules/order_list/view/all_order_list.dart';
import 'package:selling_food_store/modules/order_list/view/cancel_order_list.dart';
import 'package:selling_food_store/modules/order_list/view/confirm_order_list.dart';
import 'package:selling_food_store/modules/order_list/view/ordered_list.dart';
import 'package:selling_food_store/shared/utils/bottomsheet_utils.dart';

import '../../../shared/utils/app_color.dart';
import 'success_order_list.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderListBloc, OrderListState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 5,
          child: Scaffold(
              backgroundColor: AppColor.whiteColor,
              appBar: AppBar(
                backgroundColor: AppColor.whiteColor,
                elevation: 1.0,
                centerTitle: true,
                title: Text(
                  'titleOrderList'.tr(),
                  style: const TextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(text: 'allTab'.tr()),
                    Tab(text: 'confirmOrderTab'.tr()),
                    Tab(text: 'shippingTab'.tr()),
                    Tab(text: 'shippingSuccessTab'.tr()),
                    Tab(text: 'cancelOrderTab'.tr()),
                  ],
                  labelColor: Colors.blue,
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                ),
                leading: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppColor.blackColor,
                    )),
              ),
              body: const Column(
                children: [
                  Expanded(
                      child: TabBarView(children: [
                    AllOrderList(),
                    OrderedList(),
                    ConfirmOrderList(),
                    SuccessOrderList(),
                    CancelOrderList(),
                  ]))
                ],
              )),
        );
      },
      listener: (context, state) {
        if (state is CancelOrderState) {
          BottomSheetUtils.showBottomSheetSelectReasonForCancelOrder(
              context: context,
              onSelect: (String reason) {
                context
                    .read<OrderListBloc>()
                    .add(OnConfirmCancelOrderEvent(state.id, reason));
              },
              onClose: () {
                context.read<OrderListBloc>().add(OnCloseBottomSheetEvent());
              });
        } else if (state is CloseBottomSheetState) {
          log('bottom sheet is closed');
        } else if (state is ConfirmCancelOrderState) {
          EasyLoading.showSuccess('cancel_order_success'.tr());
          context.read<OrderListBloc>().add(OnLoadingOrderListEvent());
        } else if (state is ErrorCancelOrderState) {
          EasyLoading.showError('unknown'.tr());
        } else if (state is FeedbackProductState) {
          EasyLoading.showToast('Cảm ơn bạn đã phản hồi');
        }
      },
    );
  }
}
