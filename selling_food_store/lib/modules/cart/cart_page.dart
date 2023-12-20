import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_bloc.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_event.dart';
import 'package:selling_food_store/modules/cart/bloc/item_cart_bloc.dart';
import 'package:selling_food_store/modules/cart/view/cart_view.dart';
import 'package:selling_food_store/modules/home/bloc/home_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CartBloc()..add(LoadingCartListEvent())),
        BlocProvider(create: (context) => ItemCartBloc()),
        BlocProvider(create: (context) => HomeBloc()),
      ],
      child: const CartView(),
    );
  }
}
