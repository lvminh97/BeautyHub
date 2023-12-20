import 'package:beauty_hub_admin/models/product.dart';
import 'package:beauty_hub_admin/routes/app_routes.dart';
import 'package:beauty_hub_admin/shared/services/firebase_service.dart';
import 'package:get/get.dart';

class ProductManageController extends GetxController {
  RxList<Product> productList = RxList<Product>();

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  Future<void> getProducts() async {
    productList.value = await FirebaseService.fetchProducts();
  }

  void onAddProduct() {
    Get.toNamed(AppRoutes.addProductPage);
  }

  void onEditProduct(Product product) {
    Get.toNamed(AppRoutes.addProductPage, arguments: product);
  }
}
