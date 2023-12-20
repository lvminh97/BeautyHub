import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';

import '../../utils/app_color.dart';

class ItemProduct extends StatelessWidget {
  final Product product;
  const ItemProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return Container(
      width: (baseWidth - 16 * 2) / 2,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(width: 1.0, color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            imageUrl: product.image,
            width: (baseWidth - 16 * 2) / 2,
            height: (baseWidth - 16 * 2) / 2,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, progress) =>
                const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 12.0,
                color: AppColor.blackColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            child: Text(
              '${AppUtils.formatPrice(product.getPrice())}đ',
              style: const TextStyle(
                fontSize: 16.0,
                color: AppColor.priceProductColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CachedNetworkImage(
                  imageUrl: product.brand.logoBrand,
                  width: 20.0,
                  height: 20.0,
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: imageProvider),
                      shape: BoxShape.circle,
                      color: AppColor.primaryAppColor,
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, progress) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    product.brand.name,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: AppColor.blackColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
