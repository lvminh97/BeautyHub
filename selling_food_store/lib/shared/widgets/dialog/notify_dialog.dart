import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/shared/widgets/general/general_button.dart';

import '../../utils/app_color.dart';

class NotifyDialog extends StatelessWidget {
  final String? message;
  final NotifyTypeDialog notifyType;

  const NotifyDialog({
    super.key,
    this.message,
    required this.notifyType,
  });

  @override
  Widget build(BuildContext context) {
    switch (notifyType) {
      case NotifyTypeDialog.notifyError:
        return _buildNotifyErrorDialog(context);
      case NotifyTypeDialog.notifySuccess:
        return _buildNotifySuccessDialog(context);
      case NotifyTypeDialog.notifyConfirmSignOut:
        return _buildNotifyConfirmSignOutDialog(context);
    }
  }

  Widget _buildNotifyErrorDialog(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      title: Text('titleNotifyDialog'.tr()),
      content: Text(message ?? 'unknown'.tr()),
      actions: [
        TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text('close'.tr().toUpperCase()))
      ],
    );
  }

  Widget _buildNotifyConfirmSignOutDialog(BuildContext context) {
    return AlertDialog(
      elevation: 0.0,
      title: Text(
        'signOut'.tr(),
        style: const TextStyle(
          color: AppColor.blackColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(message ?? 'unknown'.tr()),
      actions: [
        TextButton(
            onPressed: () {
              context.pop(true);
            },
            child: Text(
              'confirmSignOut'.tr().toUpperCase(),
              style: const TextStyle(
                color: Colors.redAccent,
              ),
            )),
        TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text('close'.tr().toUpperCase()))
      ],
    );
  }

  Widget _buildNotifySuccessDialog(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      elevation: 0.0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      backgroundColor: Colors.transparent,
      content: Stack(
        children: [
          Container(
            width: baseWidth - 16 * 2,
            height: 260.0,
            margin: const EdgeInsets.only(top: 40.0),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primaryAppColor,
                        border:
                            Border.all(color: AppColor.whiteColor, width: 2.0)),
                    child: const Icon(
                      Icons.check,
                      color: AppColor.whiteColor,
                      size: 32.0,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  Text(
                    'titleForgotSuccess'.tr(),
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: AppColor.primaryAppColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    message ?? 'contentForgotPasswordSuccess'.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: AppColor.blackColor,
                    ),
                  ),
                  const SizedBox(height: 48.0),
                  GeneralButton(
                      title: 'continue'.tr(),
                      onClick: () {
                        context.pop();
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum NotifyTypeDialog { notifyError, notifySuccess, notifyConfirmSignOut }
