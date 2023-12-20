import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/confirm_order/bloc/confirm_order_bloc.dart';
import 'package:selling_food_store/modules/confirm_order/bloc/confirm_order_state.dart';
import 'package:selling_food_store/shared/widgets/items/item_maybe.dart';

import '../../../models/product.dart';

class MaybeProductList extends StatelessWidget {
  const MaybeProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmOrderBloc, ConfirmOrderState>(
        builder: (context, state) {
      List<Product> products = [];
      if (state is DisplayProductListState) {
        products = state.productList;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Có thể bạn cũng muốn',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          GridView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.45,
                crossAxisSpacing: 12.0,
              ),
              itemBuilder: (context, index) =>
                  ItemMaybe(product: products[index]))
        ],
      );
    });
  }
}
