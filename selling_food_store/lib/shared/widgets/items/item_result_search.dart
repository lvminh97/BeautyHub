import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/shared/utils/app_color.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';

import '../../../models/product.dart';

class ItemResultSearch extends StatelessWidget {
  final Product product;

  const ItemResultSearch({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        context.goNamed('productDetail', extra: product);
      },
      child: Container(
        color: AppColor.whiteColor,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Column(
          children: [
            CachedNetworkImage(
              width: baseWidth / 2,
              height: 200.0,
              imageUrl: product.image,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(image: imageProvider),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
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
                    product.name,
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: AppColor.blackColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                        width: 20.0,
                        height: 20.0,
                        imageUrl: product.brand.logoBrand,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: imageProvider),
                          ),
                        ),
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error, color: AppColor.hintGreyColor),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        product.brand.name,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: AppColor.blackColor,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    AppUtils.formatPrice(product.getPrice()),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: AppColor.priceProductColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RichText(
                      text: TextSpan(
                          text: AppUtils.formatPrice(product.cost),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: AppColor.hintGreyColor))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
