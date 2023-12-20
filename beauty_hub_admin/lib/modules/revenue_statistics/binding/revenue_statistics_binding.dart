import 'package:beauty_hub_admin/modules/revenue_statistics/controller/revenue_statistics_controller.dart';
import 'package:get/get.dart';

class RevenueStatisticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RevenueStatisticsController());
  }
}