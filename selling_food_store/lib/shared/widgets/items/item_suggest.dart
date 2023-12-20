import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';

import '../../utils/app_color.dart';

class ItemSuggest extends StatelessWidget {
  final Product product;
  const ItemSuggest({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: SizedBox(
        width: 120.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              width: 120.0,
              height: 150.0,
              imageUrl: product.image,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: AppColor.hintGreyColor),
            ),
            const SizedBox(height: 12.0),
            Text(
              product.name,
              maxLines: 2,
              style: const TextStyle(
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              '${AppUtils.formatPrice(product.getPrice())}đ',
              maxLines: 1,
              style: const TextStyle(
                color: AppColor.priceProductColor,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
