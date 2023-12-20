import 'package:beauty_hub_admin/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.offAllNamed(AppRoutes.authPage),
    );
    super.onInit();
  }
}
