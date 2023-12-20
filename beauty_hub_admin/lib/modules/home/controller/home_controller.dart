import 'package:beauty_hub_admin/shared/services/firebase_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  void onLogOutWithAdmin() {
    FirebaseService.signOut(() {
      Get.offAllNamed(AppRoutes.authPage);
    }, (error) => EasyLoading.showError(error));
  }
}
