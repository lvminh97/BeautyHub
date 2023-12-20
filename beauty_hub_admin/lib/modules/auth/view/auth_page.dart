import 'package:beauty_hub_admin/modules/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends GetView<AuthController> {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: controller.globalKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Đăng nhập',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 32.0),
                  child: Text(
                    'Beauty Hub Admin - ứng dụng giúp bạn quản lý cửa hàng dễ dàng, hiệu quả hơn',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email đăng nhập',
                    labelText: 'Email',
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Email là bắt buộc'
                      : null,
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: controller.passwordController,
                  decoration: const InputDecoration(
                    hintText: "Mật khẩu",
                    labelText: 'Mật khẩu',
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Mật khẩu là bắt buộc'
                      : null,
                ),
                const SizedBox(height: 24.0),
                MaterialButton(
                    onPressed: () {
                      controller.onLogin();
                    },
                    color: Colors.green,
                    elevation: 0.0,
                    minWidth: Get.width,
                    height: 48.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
