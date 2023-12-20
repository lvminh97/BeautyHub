import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/utils/app_color.dart';
import 'maybe_product_list.dart';

class ConfirmOrderView extends StatelessWidget {
  const ConfirmOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(backgroundColor: AppColor.whiteColor, elevation: 0.0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColor.primaryAppColor,
              size: 48.0,
            ),
            const SizedBox(height: 12.0),
            Text(
              'titleConfirmOrder'.tr(),
              style: const TextStyle(
                fontSize: 16.0,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'shippingInfoOrder'.tr(),
              style: const TextStyle(
                fontSize: 14.0,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const SizedBox(height: 8.0),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //   child: Text(
            //     'Người nhận: Nguyễn Hoàng Phúc (+84392634700)\nĐịa chỉ: Khối 10, phường Hồng Sơn, tp.Vinh.',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(color: Colors.grey.shade400),
            //   ),
            // ),
            const SizedBox(height: 12.0),
            InkWell(
              onTap: () {
                context.pushReplacementNamed('home');
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  border:
                      Border.all(width: 1.0, color: AppColor.primaryAppColor),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'homeComeBack'.tr(),
                  style: const TextStyle(color: AppColor.primaryAppColor),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            const MaybeProductList(),
          ],
        ),
      ),
    );
  }
}
