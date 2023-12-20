import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paypal_api/models/models.dart';
import 'package:selling_food_store/models/order_item.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/modules/tracking_order/bloc/tracking_order_bloc.dart';
import 'package:selling_food_store/modules/tracking_order/bloc/tracking_order_event.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';

import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../general/loading_data_widget.dart';

class ItemProductInTrackingOrder extends StatefulWidget {
  final Item item;

  const ItemProductInTrackingOrder({super.key, required this.item});

  @override
  State<ItemProductInTrackingOrder> createState() =>
      _ItemProductInTrackingOrderState();
}

class _ItemProductInTrackingOrderState
    extends State<ItemProductInTrackingOrder> {
  Product? product;

  @override
  void initState() {
    getProductInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                              image: provider, fit: BoxFit.cover),
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
                          RichText(
                              text: TextSpan(
                                  text:
                                      '${widget.item.unitAmount.value} ${widget.item.unitAmount.currencyCode}',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      decoration: TextDecoration.lineThrough,
                                      color: AppColor.hintGreyColor))),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                '${AppUtils.convertVNDToUSD(product!.getPrice())} USD',
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  'x${widget.item.quantity}',
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )
          : const LoadingDataWidget(
              loadingType: LoadingDataType.loadingItemEmpty),
    );
  }

  void getProductInfo() {
    FirebaseService.getProductByID(widget.item.desc, (productInfo) {
      setState(() {
        product = productInfo;
        OrderItem orderItem = OrderItem(
            productInfo.idProduct,
            int.tryParse(widget.item.quantity) ?? 1,
            productInfo.getPrice(),
            productInfo.brand.idBrand);
        context
            .read<TrackingOrderBloc>()
            .add(OnAddProductToTrackingOrderEvent(orderItem));
      });
    }, (error) => log('Error: $error'));
  }
}
