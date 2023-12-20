import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_color.dart';

class ReasonCancelOrderBottomSheet extends StatefulWidget {
  const ReasonCancelOrderBottomSheet({super.key});

  @override
  State<ReasonCancelOrderBottomSheet> createState() =>
      _ReasonCancelOrderBottomSheetState();
}

class _ReasonCancelOrderBottomSheetState
    extends State<ReasonCancelOrderBottomSheet> {
  int isSelected = -1;
  List<String> reasons = [
    'reason_one'.tr(),
    'reason_two'.tr(),
    'reason_three'.tr(),
    'reason_four'.tr(),
    'reason_five'.tr(),
  ];
  
  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16.0),
        Text(
          'title_cancel_order'.tr(),
          style: const TextStyle(
            fontSize: 18.0,
            color: AppColor.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16.0),
        ListView.builder(
          shrinkWrap: true,
          itemCount: reasons.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => RadioListTile(
              value: index,
              title: Text(
                reasons[index],
                style: const TextStyle(
                  fontSize: 14.0,
                  color: AppColor.blackColor,
                ),
              ),
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: Colors.pinkAccent,
              groupValue: isSelected,
              onChanged: (value) {
                setState(() {
                  isSelected = value ?? -1;
                });
              }),
        ),
        const SizedBox(height: 24.0),
        InkWell(
          onTap: () {
            context.pop(reasons[isSelected]);
          },
          child: Container(
            width: baseWidth - 16 * 2,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.pinkAccent,
            ),
            child: Text(
              'confirm_cancel_order'.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
