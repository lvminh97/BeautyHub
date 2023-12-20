import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/modules/order/bloc/order_bloc.dart';
import 'package:selling_food_store/modules/order/bloc/order_event.dart';
import 'package:selling_food_store/modules/order/bloc/update_number_product_bloc.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/widgets/general/loading_data_widget.dart';

import '../../../models/product.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';

class ItemProductOrderInfo extends StatefulWidget {
  final Cart cart;
  final Function(double) onUpdate;

  const ItemProductOrderInfo({
    super.key,
    required this.cart,
    required this.onUpdate,
  });

  @override
  State<ItemProductOrderInfo> createState() => _ItemProductOrderInfoState();
}

class _ItemProductOrderInfoState extends State<ItemProductOrderInfo> {
  int quantity = 0;
  double price = 0;
  Product? product;

  @override
  void initState() {
    quantity = widget.cart.quantity;
    getProductInfo();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ItemProductOrderInfo oldWidget) {
    if (oldWidget.cart.productID != widget.cart.productID) {
      getProductInfo();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    DateTime shippingDateTime =
        widget.cart.dateTime.add(const Duration(days: 2));
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: product != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CachedNetworkImage(
                      imageUrl: product!.brand.logoBrand,
                      width: 30.0,
                      height: 30.0,
                      fit: BoxFit.cover,
                      imageBuilder: (context, provider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.primaryAppColor,
                          image: DecorationImage(
                            image: provider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error, color: AppColor.hintGreyColor),
                    ),
                    const SizedBox(width: 12.0),
                    Text(
                      product!.brand.name,
                      style: const TextStyle(
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: product!.image,
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error, color: AppColor.hintGreyColor),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            product!.name,
                            maxLines: 2,
                            style: const TextStyle(
                              fontSize: 14.0,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            product!.categories
                                .map((e) => e.name)
                                .toString()
                                .replaceAll('(', '')
                                .replaceAll(')', ''),
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 12.0,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            '${AppUtils.formatPrice(price)}đ',
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 16.0,
                              overflow: TextOverflow.ellipsis,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      text:
                                          '${AppUtils.formatPrice(product!.cost)}đ',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: AppColor.hintGreyColor))),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      increaseNumberProduct();
                                    },
                                    child: const Icon(
                                      Icons.add,
                                      size: 16.0,
                                      color: AppColor.primaryAppColor,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Text(
                                      quantity.toString(),
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        color: AppColor.blackColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      decreaseNumberProduct();
                                    },
                                    child: const Icon(
                                      Icons.remove,
                                      size: 16.0,
                                      color: AppColor.primaryAppColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 12.0),
                Text(
                  '${'shippingOrderDate'.tr()} ${AppUtils.formatDateTime(shippingDateTime)}',
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14.0,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          : const LoadingDataWidget(
              loadingType: LoadingDataType.loadingItemEmpty),
    );
  }

  void getProductInfo() {
    FirebaseService.getProductByID(widget.cart.productID, (productInfo) {
      setState(() {
        product = productInfo;
        if (product != null) {
          price = product!.getPrice();
          double pricePerItem = price * quantity;
          context
              .read<UpdateNumberProductBloc>()
              .add(OnCalculateTotalPriceEvent(pricePerItem));
          context.read<OrderBloc>().add(OnAddProductToOrderInfoEvent(
              product!.convertProductToItem(quantity),
              product!.mapProductToOrderItem(quantity)));
        }
      });
    }, (error) => log('Error: $error'));
  }

  void increaseNumberProduct() {
    setState(() {
      quantity++;
      price = product!.getPrice();
      widget.onUpdate(price);
    });
  }

  void decreaseNumberProduct() {
    setState(() {
      quantity--;
      if (quantity <= 0) {
        quantity = 1;
      } else {
        price = product!.getPrice();
        widget.onUpdate(-price);
      }
      if (product!.isProductExistsInCart(product!.idProduct)) {
        widget.cart.updateQuantity(quantity);
      }
    });
  }
}
