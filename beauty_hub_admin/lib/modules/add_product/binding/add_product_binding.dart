import 'package:beauty_hub_admin/modules/add_product/controller/add_product_controller.dart';
import 'package:get/get.dart';

class AddProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddProductController());
  }
}