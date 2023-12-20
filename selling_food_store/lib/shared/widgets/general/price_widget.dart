import 'package:flutter/material.dart';
import 'package:selling_food_store/shared/utils/app_color.dart';
import 'package:selling_food_store/shared/utils/app_utils.dart';

import '../../utils/strings.dart';

class PriceWidget extends StatelessWidget {
  final double value;
  final double? textSize;
  final bool? isUnit;
  final bool? isPrice;
  final bool? isTextBold;
  final double? width;
  final Color? unitTextColor;
  final Color? priceTextColor;

  const PriceWidget({
    super.key,
    required this.value,
    this.textSize,
    this.isUnit,
    this.isPrice,
    this.isTextBold,
    this.width,
    this.unitTextColor,
    this.priceTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Text(
              AppUtils.formatPrice(value),
              key: key,
              maxLines: 1,
              style: TextStyle(
                color: priceTextColor ?? AppColor.hintGreyColor,
                overflow: TextOverflow.ellipsis,
                fontSize: textSize ?? 14.0,
                fontWeight: isTextBold == true ? FontWeight.bold : null,
              ),
            ),
            isPrice == true
                ? Container()
                : const Divider(),
          ],
        ),
        isUnit == true
            ? Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  Strings.unitPrice,
                  style: TextStyle(
                    color: unitTextColor ?? AppColor.hintGreyColor,
                    fontSize: 12.0,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
