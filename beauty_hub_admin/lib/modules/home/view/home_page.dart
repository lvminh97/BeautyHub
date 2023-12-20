import 'package:beauty_hub_admin/modules/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Beauty Hub Admin',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.article_outlined),
              title: const Text('Quản lý sản phẩm'),
              onTap: () {
                Get.toNamed(AppRoutes.productManagePage);
              },
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Quản lý đơn hàng'),
              onTap: () {
                Get.toNamed(AppRoutes.orderManagePage);
              },
            ),
            ListTile(
              leading: const Icon(Icons.money),
              title: const Text('Doanh thu của cửa hàng'),
              onTap: () {
                Get.toNamed(AppRoutes.revenueStatisticsPage);
              },
            ),
            const Spacer(),
            MaterialButton(
              onPressed: () {
                controller.onLogOutWithAdmin();
              },
              minWidth: Get.width,
              height: 48.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
              ),
              color: Colors.grey.shade100,
              elevation: 0.0,
              disabledElevation: 0.0,
              child: const Text(
                'Đăng xuất',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
