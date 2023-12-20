import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_bloc.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_event.dart';
import 'package:selling_food_store/modules/cart/bloc/cart_state.dart';
import 'package:selling_food_store/modules/cart/bloc/item_cart_bloc.dart';
import 'package:selling_food_store/modules/cart/view/bottom_cart_panel.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/services/hive_service.dart';
import 'package:selling_food_store/shared/widgets/general/empty_data_widget.dart';
import 'package:selling_food_store/shared/widgets/general/loading_data_widget.dart';
import 'package:selling_food_store/shared/widgets/general/search_bar.dart'
    as searchBar;
import 'package:selling_food_store/shared/widgets/items/item_product.dart';

import '../../../models/cart.dart';
import '../../../shared/utils/app_color.dart';
import '../../../shared/widgets/items/item_cart.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<Cart> _cartItems = [];
  bool isNotSignIn = false;
  bool isDeleteCart = false;
  bool isLoading = false;

  List<Cart> removeCartList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      if (state is DisplayNotSignInState) {
        isNotSignIn = true;
      } else if (state is LoadingCartListState) {
        isLoading = true;
      } else if (state is DisplayCartListState) {
        isLoading = false;
        _cartItems = state.cartList;
      }
      return Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          elevation: 0.0,
          centerTitle: true,
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColor.blackColor,
              )),
          title: isNotSignIn
              ? null
              : _cartItems.isEmpty
                  ? Text('yourCart'.tr(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ))
                  : searchBar.SearchBar(
                      hintText: 'searchCartText'.tr(),
                      backgroundColor: AppColor.shimer200Color,
                      onSearch: () {
                        showSearch(
                          context: context,
                          delegate: CartDelegate(),
                        );
                      },
                    ),
          actions: isNotSignIn
              ? null
              : _cartItems.isEmpty
                  ? null
                  : [
                      BlocBuilder<ItemCartBloc, CartState>(
                          builder: (context, state) {
                        if (state is OnDeleteCartState) {
                          isDeleteCart = state.value;
                        } else if (state is CancelDeleteCartState) {
                          isDeleteCart = false;
                        } else if (state is ConfirmDeleteCartState) {
                          isDeleteCart = false;
                        }
                        return isDeleteCart
                            ? const SizedBox()
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    isDeleteCart = !isDeleteCart;
                                    context
                                        .read<ItemCartBloc>()
                                        .add(OnDeleteCartEvent(isDeleteCart));
                                  });
                                },
                                splashColor: AppColor.transparentColor,
                                highlightColor: AppColor.transparentColor,
                                focusColor: AppColor.transparentColor,
                                hoverColor: AppColor.transparentColor,
                                icon: const Icon(Icons.delete),
                                color: AppColor.hintGreyColor,
                              );
                      }),
                      const SizedBox(width: 8.0),
                    ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isNotSignIn
                ? EmptyDataWidget(
                    emptyType: EmptyType.profileEmpty,
                    onClick: () {
                      context.pushNamed('signIn');
                    })
                : isLoading
                    ? const LoadingDataWidget(
                        loadingType: LoadingDataType.loadingCartList)
                    : _cartItems.isNotEmpty
                        ? Expanded(
                            child: Column(
                              children: [
                                Container(
                                    height: 12.0, color: AppColor.dividerColor),
                                Expanded(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: _cartItems.length,
                                    itemBuilder: (context, index) => ItemCart(
                                      cart: _cartItems[index],
                                      onAddItem: (itemCart) {
                                        removeCartList.add(itemCart);
                                      },
                                      onRemoveItem: (itemCart) {
                                        if (removeCartList.contains(itemCart)) {
                                          removeCartList.remove(itemCart);
                                        }
                                      },
                                    ),
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            Container(
                                                height: 12.0,
                                                color: AppColor.dividerColor),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const EmptyDataWidget(emptyType: EmptyType.cartEmpty)
          ],
        ),
        persistentFooterButtons: _cartItems.isNotEmpty
            ? [
                BottomCartPanel(
                  cartList: _cartItems,
                  onConfirmDelete: () {
                    context
                        .read<ItemCartBloc>()
                        .add(OnConfirmDeleteCart(removeCartList));
                  },
                )
              ]
            : null,
      );
    });
  }
}

class CartDelegate extends SearchDelegate<Cart> {
  List<String> keywords = HiveService.getKeywords();

  List<Product> productList = [];

  CartDelegate() {
    getProducts();
  }

  Future<void> getProducts() async {
    productList = await FirebaseService.fetchProducts();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: AppColor.whiteColor,
        iconTheme: IconThemeData(color: AppColor.blackColor),
        actionsIconTheme: IconThemeData(color: AppColor.blackColor),
      ),
      inputDecorationTheme:
          const InputDecorationTheme(border: InputBorder.none),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isNotEmpty) {
              query = '';
            } else {
              context.pop();
            }
          },
          icon: const Icon(Icons.clear)),
      const SizedBox(width: 12.0),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: AppColor.blackColor,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    log('build Results');
    return SizedBox();
    // HiveService.addKeyword(query);
    // List<Cart> resultList = HiveService.getCartList()
    //     .where((item) =>
    //         item.productID.toLowerCase().contains(query.toLowerCase()))
    //     .toList();
    // return ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: resultList.length,
    //     itemBuilder: (context, index) =>
    //         ItemResultSearch(product: resultList[index]));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    log('build Suggestions');
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: AppColor.whiteColor,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: keywords.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'recentSearch'.tr(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Wrap(
                    children: List.generate(
                      keywords.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          disabledColor: AppColor.shimer200Color,
                          label: Text(
                            keywords[index],
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: AppColor.blackColor,
                            ),
                          ),
                          selected: false,
                        ),
                      ),
                    ).toList(),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'youWant'.tr(),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  GridView.builder(
                    itemCount: productList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.65,
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemBuilder: ((context, index) {
                      return ItemProduct(product: productList[index]);
                    }),
                  )
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
