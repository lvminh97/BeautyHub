import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/order/bloc/order_bloc.dart';
import 'package:selling_food_store/modules/order/bloc/order_state.dart';

import '../../../shared/utils/app_color.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      String name = '';
      String address = 'phucnguyen.mobiledeveloper@gmail.com';
      if (state is DisplayUserInfoState) {
        name = state.name;
        address = state.address;
      }
      return ListTile(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        minLeadingWidth: 12.0,
        horizontalTitleGap: 12.0,
        leading: const Icon(Icons.contact_mail_outlined),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 16.0,
            color: AppColor.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          address,
          style: const TextStyle(
            fontSize: 14.0,
            color: Color.fromARGB(255, 148, 144, 144),
          ),
        ),
        trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 16.0,
            )),
      );
    });
  }
}
