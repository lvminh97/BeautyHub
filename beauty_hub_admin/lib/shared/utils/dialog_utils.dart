import 'package:beauty_hub_admin/shared/widgets/delete_product_dialog.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showEditProductDialog(
    BuildContext context,
    String nameProduct,
    Function() onDelete,
  ) {
    showDialog(
      context: context,
      builder: (context) => DeleteProductDialog(name: nameProduct),
    ).then((value) {
      if(value == null) {

      } else {
        onDelete();
      }
    });
  }
}
