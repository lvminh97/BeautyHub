import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/shared/utils/app_color.dart';
import 'package:selling_food_store/shared/utils/image_constants.dart';

import '../../shared/utils/strings.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImageConstants.logoApp,
                width: 64.0,
                height: 64.0,
              ),
              const SizedBox(width: 12.0),
              const Text(
                Strings.appName,
                style: TextStyle(
                  fontSize: 40.0,
                  color: AppColor.sologanColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Center(
            child: Text(
              Strings.sologanApp,
              style: TextStyle(
                fontSize: 16.0,
                color: AppColor.sologanColor,
              ),
            ),
          )
              .animate(onComplete: (control) {
                context.go('/home');
              })
              .fadeIn(duration: 3000.ms, delay: 600.ms)
              .move(
                begin: const Offset(-32, 0),
                curve: Curves.easeOutQuad,
              ),
        ],
      ),
    );
  }
}
