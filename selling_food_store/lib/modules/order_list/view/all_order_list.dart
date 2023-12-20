import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/models/order.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_bloc.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_state.dart';

import '../../../shared/widgets/general/empty_data_widget.dart';
import '../../../shared/widgets/items/item_order.dart';

class AllOrderList extends StatelessWidget {
  const AllOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderListBloc, OrderListState>(
        builder: (context, state) {
      List<Order> orders = [];
      if (state is DisplayOrderListState) {
        orders = state.allOrders;
      }
      return orders.isNotEmpty
          ? ListView.separated(
              itemCount: orders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => ItemOrder(order: orders[index]),
              separatorBuilder: (context, index) => Container(
                    height: 10.0,
                    color: Colors.grey.shade100,
                  ))
          : const EmptyDataWidget(emptyType: EmptyType.orderListEmpty);
    });
  }
}
