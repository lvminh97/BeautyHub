import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/modules/detail/bloc/brand_info_bloc.dart';
import 'package:selling_food_store/modules/detail/bloc/brand_info_event.dart';
import 'package:selling_food_store/modules/detail/bloc/product_detail_bloc.dart';
import 'package:selling_food_store/modules/detail/view/product_detail_view.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ProductDetailBloc()
              ..add(LoadingProductDetailEvent(product.idProduct))),
        BlocProvider(
            create: (context) => BrandInfoBloc()
              ..add(LoadingBrandInfoEvent(product.brand.idBrand))),
      ],
      child: ProductDetailView(product: product),
    );
  }
}
