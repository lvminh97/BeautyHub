import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_color.dart';

class ChooseBirthDay extends StatefulWidget {
  const ChooseBirthDay({super.key});

  @override
  State<ChooseBirthDay> createState() => _ChooseBirthDayState();
}

class _ChooseBirthDayState extends State<ChooseBirthDay> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.close)),
            Expanded(
              child: Text(
                'chooseBirthDay'.tr(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop(dateTime);
              },
              child: Text(
                'choose'.tr(),
                style: const TextStyle(
                  color: AppColor.primaryAppColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 300.0,
          width: MediaQuery.of(context).size.width,
          child: CupertinoDatePicker(
            initialDateTime: dateTime,
            dateOrder: DatePickerDateOrder.dmy,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime value) {
              setState(() {
                dateTime = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
