import 'package:flutter/material.dart';
import 'package:selling_food_store/models/product.dart';
import 'package:selling_food_store/shared/widgets/general/add_to_cart_bottomSheet.dart';
import 'package:selling_food_store/shared/widgets/general/choose_birthday.dart';
import 'package:selling_food_store/shared/widgets/general/reason_cancel_order_bottomsheet.dart';

import 'app_color.dart';

class BottomSheetUtils {
  static Future<void> showBottomSheetAddProductToCart({
    required BuildContext context,
    required Product product,
    required Function(Product, int) onAdd,
    Function()? onClose,
  }) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.whiteColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      )),
      builder: (context) => AddToCartBottomSheet(product: product),
    ).then((value) {
      if (value != null) {
        Product product = Product.fromJson(value['product']);
        int quantity = value['quantity'] as int;
        onAdd(product, quantity);
      } else {
        if (onClose != null) {
          onClose();
        }
      }
    });
  }

  static Future<void> showBottomSheetChooseBirthDay({
    required BuildContext context,
    required Function(DateTime) onSelect,
  }) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.whiteColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      )),
      builder: (context) => const ChooseBirthDay(),
    ).then((value) {
      if (value != null) {
        onSelect(value);
      }
    });
  }

  static Future<void> showBottomSheetSelectReasonForCancelOrder({
    required BuildContext context,
    required Function(String) onSelect,
    Function()? onClose,
  }) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.whiteColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(8.0),
      )),
      builder: (context) => const ReasonCancelOrderBottomSheet(),
    ).then((value) {
      if (value != null) {
        onSelect(value);
      } else {
        if (onClose != null) {
          onClose();
        }
      }
    });
  }
}
