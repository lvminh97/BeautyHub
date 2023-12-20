import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/change_payment/bloc/change_payment_bloc.dart';

import 'view/change_payment_view.dart';

class ChangePaymentPage extends StatelessWidget {
  const ChangePaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePaymentBloc(),
      child: const ChangePaymentView(),
    );
  }
}
