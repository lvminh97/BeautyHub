import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/change_password/bloc/change_password_bloc.dart';
import 'package:selling_food_store/modules/change_password/bloc/change_password_event.dart';
import 'package:selling_food_store/modules/change_password/bloc/change_password_state.dart';
import 'package:selling_food_store/shared/widgets/general/general_button.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/widgets/general/text_input.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String oldPassword = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) => Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColor.whiteColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColor.darkColor,
                )),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12.0),
              Text(
                'change_password'.tr().toUpperCase(),
                style: const TextStyle(
                  fontSize: 16.0,
                  color: AppColor.darkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'title_change_password'.tr(),
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40.0),
              TextInput(
                prefixIcon: Icons.lock_outlined,
                textController: oldPasswordController,
                hint: 'old_password'.tr(),
                isHaveTitle: true,
                title: 'old_password'.tr(),
              ),
              const SizedBox(height: 16.0),
              TextInput(
                prefixIcon: Icons.lock_outlined,
                textController: newPasswordController,
                hint: 'new_password'.tr(),
                help: 'note_new_password'.tr(),
                isHaveTitle: true,
                title: 'new_password'.tr(),
              ),
              const SizedBox(height: 16.0),
              TextInput(
                prefixIcon: Icons.lock_outlined,
                textController: confirmPasswordController,
                hint: 'confirm_new_password'.tr(),
                help: 'note_confirm_password'.tr(),
                isHaveTitle: true,
                title: 'confirm_new_password'.tr(),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          GeneralButton(
            title: 'confirm'.tr(),
            onClick: () {
              context.read<ChangePasswordBloc>().add(OnChangePasswordEvent(
                  oldPassword, newPasswordController.text));
            },
          )
        ],
      ),
      listener: (context, state) {
        if (state is GetCredentialState) {
          oldPassword = state.oldPassword;
          oldPasswordController.text = state.oldPassword;
        } else if (state is ChangePasswordSuccessState) {
          EasyLoading.showSuccess('Đổi mật khẩu thành công');
        } else if (state is ChangePasswordFailureState) {
          EasyLoading.showError(state.error);
        }
      },
    );
  }
}
