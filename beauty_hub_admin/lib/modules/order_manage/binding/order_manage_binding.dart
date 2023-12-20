import 'package:beauty_hub_admin/modules/order_manage/controller/order_manage_controller.dart';
import 'package:get/get.dart';

class OrderManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderManageController());
  }
}