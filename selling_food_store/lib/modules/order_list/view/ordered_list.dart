import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/order.dart';
import '../../../shared/widgets/general/empty_data_widget.dart';
import '../../../shared/widgets/items/item_order.dart';
import '../bloc/order_list_bloc.dart';
import '../bloc/order_list_state.dart';

class OrderedList extends StatelessWidget {
  const OrderedList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderListBloc, OrderListState>(
        builder: (context, state) {
      List<Order> orders = [];
      bool isLoading = true;
      if (state is DisplayOrderListState) {
        isLoading = false;
        orders = state.requestOrders;
      }
      return isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isNotEmpty
              ? ListView.separated(
                  itemCount: orders.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      ItemOrder(order: orders[index]),
                  separatorBuilder: (context, index) => Container(
                        height: 10.0,
                        color: Colors.grey.shade100,
                      ))
              : const EmptyDataWidget(emptyType: EmptyType.orderListEmpty);
    });
  }
}
