import 'package:beauty_hub_admin/routes/app_routes.dart';
import 'package:beauty_hub_admin/shared/constants/app_constants.dart';
import 'package:beauty_hub_admin/shared/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static final _prefs = Get.find<SharedPreferences>();

  Future<void> onLogin() async {
    if (globalKey.currentState!.validate()) {
      final userCredential = await FirebaseService.loginWithEmailPassword(
          emailController.text,
          passwordController.text,
          (error) => EasyLoading.showError(error));
      if (userCredential != null) {
        if (userCredential.user != null) {
          _prefs.setString(AppConstants.idUser, userCredential.user!.uid);
          Get.offAllNamed(AppRoutes.homePage);
        }
      }
    }
  }
}
