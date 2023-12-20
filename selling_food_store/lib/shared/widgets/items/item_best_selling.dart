import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';

import '../../utils/app_color.dart';

class ItemBestSelling extends StatelessWidget {
  final Product product;
  final Function(Product) onBuyNow;
  final Function() onClick;

  const ItemBestSelling({
    super.key,
    required this.onClick,
    required this.product,
    required this.onBuyNow,
  });

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width * 0.45;
    return InkWell(
      onTap: () {
        onClick();
      },
      child: Container(
        width: baseWidth,
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              width: baseWidth,
              height: 220.0,
              imageUrl: product.image,
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) =>
                  Icon(Icons.error, color: AppColor.hintGreyColor),
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
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.baseColor,
                      image: DecorationImage(image: imageProvider),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error, color: AppColor.hintGreyColor),
                ),
                const SizedBox(width: 8.0),
                Text(
                  product.brand.name,
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColor.hintGreyColor,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              product.name,
              maxLines: 2,
              style: const TextStyle(
                color: AppColor.blackColor,
                overflow: TextOverflow.ellipsis,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: AppUtils.formatPrice(product.cost),
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: AppColor.hintGreyColor))),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.discount_outlined,
                          color: Colors.deepOrange,
                          size: 16.0,
                        ),
                        Text(
                          '${product.discount!.toInt()}%',
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.deepOrange,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  AppUtils.formatPrice(product.getPrice()),
                  maxLines: 1,
                  style: const TextStyle(
                    color: AppColor.priceProductColor,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            product.sold != null && product.sold! > 500
                ? Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      'Đã bán: ${AppUtils.formatSold(product.sold!)}',
                      maxLines: 2,
                      style: const TextStyle(
                        color: AppColor.blackColor,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12.0,
                      ),
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: 8.0),
            MaterialButton(
              onPressed: () {
                onBuyNow(product);
              },
              elevation: 0.0,
              minWidth: baseWidth,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              color: AppColor.buttonBuyColor,
              child: Text(
                'textbuyNow'.tr(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
            RatingBar.builder(
                itemCount: 5,
                initialRating: 3,
                allowHalfRating: true,
                itemSize: 16.0,
                itemBuilder: ((context, index) => const Icon(
                      Icons.star,
                      color: AppColor.starColor,
                    )),
                onRatingUpdate: (value) {})
          ],
        ),
      ),
    );
  }
}
