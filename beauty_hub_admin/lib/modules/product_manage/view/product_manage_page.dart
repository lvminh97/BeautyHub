import 'package:beauty_hub_admin/modules/product_manage/controller/product_manage_controller.dart';
import 'package:beauty_hub_admin/shared/items/item_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductManagePage extends GetView<ProductManageController> {
  const ProductManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh sách sản phẩm',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                controller.onAddProduct();
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => controller.productList.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                      itemBuilder: ((context, index) => ItemProduct(
                            product: controller.productList[index],
                            onEdit: (product) {
                              controller.onEditProduct(product);
                            },
                          )),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: controller.productList.length,
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
