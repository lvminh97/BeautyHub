import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/dependency_injection.dart';
import 'package:selling_food_store/modules/order/bloc/order_bloc.dart';
import 'package:selling_food_store/modules/order/bloc/order_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/utils/app_color.dart';
import '../../../shared/utils/strings.dart';

class ChoosePaymentMethod extends StatefulWidget {
  const ChoosePaymentMethod({super.key});

  @override
  State<ChoosePaymentMethod> createState() => _ChoosePaymentMethodState();
}

class _ChoosePaymentMethodState extends State<ChoosePaymentMethod> {
  final prefs = getIt.get<SharedPreferences>();
  int paymentMethodValue = -1;

  @override
  void initState() {
    paymentMethodValue = prefs.getInt(Strings.paymentMethod) ?? -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'paymentMethod'.tr(),
            style: const TextStyle(
              fontSize: 16.0,
              color: AppColor.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          RadioListTile(
            value: 0,
            groupValue: paymentMethodValue,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.trailing,
            title: Text(
              'codPaymentMethod'.tr(),
              style: const TextStyle(
                fontSize: 14.0,
                color: AppColor.blackColor,
              ),
            ),
            onChanged: (value) {
              setState(() {
                paymentMethodValue = 0;
                context.read<OrderBloc>().add(
                    OnChoosePaymentMethodEvent(value ?? paymentMethodValue));
              });
            },
          ),
          RadioListTile(
            value: 1,
            groupValue: paymentMethodValue,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.trailing,
            title: Text(
              'paypalPaymentMethod'.tr(),
              style: const TextStyle(
                fontSize: 14.0,
                color: AppColor.blackColor,
              ),
            ),
            onChanged: (value) {
              setState(() {
                paymentMethodValue = 1;
                context.read<OrderBloc>().add(
                    OnChoosePaymentMethodEvent(value ?? paymentMethodValue));
              });
            },
          ),
          RadioListTile(
            value: 2,
            groupValue: paymentMethodValue,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.trailing,
            title: Text(
              'momoPaymentMethod'.tr(),
              style: const TextStyle(
                fontSize: 14.0,
                color: AppColor.blackColor,
              ),
            ),
            onChanged: (value) {
              setState(() {
                paymentMethodValue = 2;
                context.read<OrderBloc>().add(
                    OnChoosePaymentMethodEvent(value ?? paymentMethodValue));
              });
            },
          ),
        ],
      ),
    );
  }
}
