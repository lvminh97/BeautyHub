import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_bloc.dart';
import 'package:selling_food_store/modules/order_list/bloc/order_list_event.dart';
import 'package:selling_food_store/modules/order_list/view/order_list_view.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        bool isClosed = OrderListBloc().isClosed;
        if (isClosed) {
          return OrderListBloc();
        }
        return OrderListBloc()..add(OnLoadingOrderListEvent());
      },
      child: const OrderListView(),
    );
  }
}
