import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_bloc.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_event.dart';
import 'package:selling_food_store/shared/widgets/items/item_product_in_order.dart';

import '../../../models/order.dart';
import '../../utils/app_color.dart';

class ItemOrder extends StatefulWidget {
  final Order order;

  const ItemOrder({
    super.key,
    required this.order,
  });

  @override
  State<ItemOrder> createState() => _ItemOrderState();
}

class _ItemOrderState extends State<ItemOrder> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.order.orderItems.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => ItemProductInOrder(
                  orderItem: widget.order.orderItems[index],
                  status: widget.order.status,
                )),
        widget.order.status == 'CREATED'
            ? InkWell(
                onTap: () {
                  context
                      .read<OrderListBloc>()
                      .add(OnCancelOrderEvent(widget.order.orderId));
                },
                child: Container(
                  width: baseWidth - 2 * 12,
                  margin: const EdgeInsets.only(
                      bottom: 12.0, left: 12.0, right: 12.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(width: 1.0, color: Colors.black12)),
                  child: Text(
                    'cancelOrderText'.tr(),
                    style: const TextStyle(
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
