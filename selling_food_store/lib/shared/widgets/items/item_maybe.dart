import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selling_food_store/models/product.dart';

import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';

class ItemMaybe extends StatelessWidget {
  final Product product;
  const ItemMaybe({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: baseWidth * 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                width: double.infinity,
                height: 220.0,
                imageUrl: product.image,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: AppColor.hintGreyColor),
              ),
              Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 1.0,
                          color: Colors.deepOrange,
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.discount,
                          color: Colors.deepOrange,
                          size: 16.0,
                        ),
                        const SizedBox(width: 4.0),
                        product.discount != null
                            ? Text(
                                '${product.discount!.toInt().toString()}%',
                                maxLines: 2,
                                style: const TextStyle(
                                  color: Colors.deepOrange,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14.0,
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            product.name,
            maxLines: 2,
            style: const TextStyle(
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
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
                    CircularProgressIndicator(value: downloadProgress.progress),
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
          RichText(
              text: TextSpan(
                  text: AppUtils.formatPrice(product.cost),
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: AppColor.hintGreyColor))),
          const SizedBox(height: 2.0),
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
          const SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialButton(
                onPressed: () {},
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                color: AppColor.buttonBuyColor,
                child: Text(
                  'textbuyNow'.tr(),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: IconButton(
                    onPressed: () {},
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.black,
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
