import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/models/cart.dart';
import 'package:selling_food_store/models/order_item.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';
import 'package:uuid/uuid.dart';

import '../../../modules/order_list/bloc/order_list_bloc.dart';
import '../../../modules/order_list/bloc/order_list_event.dart';
import '../../utils/app_color.dart';
import '../../utils/show_dialog_utils.dart';

class ItemProductInOrder extends StatefulWidget {
  final OrderItem orderItem;
  final String status;

  const ItemProductInOrder({
    super.key,
    required this.orderItem,
    required this.status,
  });

  @override
  State<ItemProductInOrder> createState() => _ItemProductInOrderState();
}

class _ItemProductInOrderState extends State<ItemProductInOrder> {
  Product? product;

  @override
  void initState() {
    getProductInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      child: product != null
          ? Column(
              children: [
                ListTile(
                  horizontalTitleGap: 0.0,
                  leading: CachedNetworkImage(
                    width: 30.0,
                    height: 30.0,
                    imageUrl: product!.brand.logoBrand,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.baseColor,
                        image: DecorationImage(
                          image: imageProvider,
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
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    product!.brand.name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    AppUtils.formatOrderStatus(widget.status),
                    style: TextStyle(
                      color: AppUtils.mapColorByStatus(widget.status),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CachedNetworkImage(
                      width: 80.0,
                      height: 80.0,
                      imageUrl: product!.image,
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
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            product!.name,
                            maxLines: 2,
                            style: const TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 14.0,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppUtils.formatOrderTitleStatus(widget.status),
                                style: const TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppUtils.formatPrice(product!.getPrice()),
                                    style: const TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'x${widget.orderItem.quantity}',
                                    style: const TextStyle(
                                      color: AppColor.blackColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                widget.status == 'SUCCESS'
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                onRepurchasee();
                              },
                              child: Container(
                                width: baseWidth / 3,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                        width: 1.0, color: Colors.black12)),
                                child: Text(
                                  'repurchase'.tr(),
                                  style: const TextStyle(
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            InkWell(
                              onTap: () {
                                ShowDialogUtils.showDialogFeedback(context,
                                    (rating, review) {
                                  context.read<OrderListBloc>().add(
                                      OnFeedbackProductEvent(rating, review,
                                          widget.orderItem.productId));
                                });
                              },
                              child: Container(
                                width: baseWidth / 3,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: Colors.redAccent),
                                child: Text(
                                  'feedback'.tr(),
                                  style: const TextStyle(
                                    color: AppColor.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : widget.status == 'CANCEL'
                        ? InkWell(
                            onTap: () {
                              onRepurchasee();
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: baseWidth / 3,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                        width: 1.0, color: Colors.black12)),
                                child: Text(
                                  'buyNow'.tr(),
                                  style: const TextStyle(
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
              ],
            )
          : const SizedBox(),
    );
  }

  void onRepurchasee() {
    String idCart = const Uuid().v4();
    Cart cart = Cart(idCart, widget.orderItem.productId,
        widget.orderItem.quantity, DateTime.now());
    context.goNamed('orderListRequestOrder', extra: {
      "cartList": [cart],
      "isBuyNow": true
    });
  }

  void getProductInfo() {
    FirebaseService.getProductByID(widget.orderItem.productId, (productInfo) {
      setState(() {
        product = productInfo;
      });
    }, (error) => log('Error: $error'));
  }
}
