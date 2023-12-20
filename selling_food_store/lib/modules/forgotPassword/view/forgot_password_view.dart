import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/forgotPassword/bloc/forgot_password_bloc.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/widgets/general/general_button.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColor.blackColor,
            )),
        title: Text(
          'titleForgotPassword'.tr(),
          style: const TextStyle(
            fontSize: 16.0,
            color: AppColor.blackColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const SizedBox(height: 12.0),
            Text(
              'contentForgotPassword'.tr(),
              style: const TextStyle(
                fontSize: 14.0,
                color: AppColor.blackColor,
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'hintEmailText'.tr(),
                prefixIcon: const Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 24.0),
            GeneralButton(
              title: 'confirm'.tr(),
              onClick: () {
                if (emailController.text.isNotEmpty) {
                  context
                      .read<ForgotPasswordBloc>()
                      .onForgotPassword(context, emailController.text);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
