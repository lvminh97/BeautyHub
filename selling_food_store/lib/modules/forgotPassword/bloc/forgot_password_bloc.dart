import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/forgotPassword/bloc/forgot_password_state.dart';
import 'package:selling_food_store/shared/services/firebase_service.dart';
import 'package:selling_food_store/shared/widgets/dialog/notify_dialog.dart';

import '../../../shared/utils/show_dialog_utils.dart';

class ForgotPasswordBloc extends BlocBase<ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordState());

  void onForgotPassword(BuildContext context, String email) {
    FirebaseService.forgotPasswordAccount(email, () {
      ShowDialogUtils.showDialogNotify(
        context: context,
        message: 'contentForgotPasswordSuccess'.tr(),
        typeDialog: NotifyTypeDialog.notifySuccess,
        onClose: () {},
      );
    }, (error) {
      log('Error: ${error.toString()}');
      ShowDialogUtils.showDialogNotify(
          context: context,
          message: error,
          typeDialog: NotifyTypeDialog.notifyError,
          onClose: () {});
    });
  }
}
