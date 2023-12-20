import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/confirm_order/bloc/confirm_order_bloc.dart';
import 'package:selling_food_store/modules/confirm_order/bloc/confirm_order_event.dart';
import 'package:selling_food_store/modules/confirm_order/view/confirm_order_view.dart';

class ConfirmOrderPage extends StatelessWidget {
  const ConfirmOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmOrderBloc()..add(OnInitConfirmOrderEvent()),
      child: const ConfirmOrderView(),
    );
  }
}
