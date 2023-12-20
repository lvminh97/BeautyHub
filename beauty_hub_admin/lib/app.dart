import 'package:beauty_hub_admin/routes/app_routes.dart';
import 'package:beauty_hub_admin/routes/pages.dart';
import 'package:beauty_hub_admin/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = Get.find<SharedPreferences>();
    return GetMaterialApp(
      title: 'Beauty Hub Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      initialRoute: prefs.getString(AppConstants.idUser) == null
          ? AppRoutes.splashPage
          : AppRoutes.homePage,
      getPages: pages,
      builder: EasyLoading.init(),
    );
  }
}
