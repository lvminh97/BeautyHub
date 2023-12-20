import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:selling_food_store/modules/notification/bloc/notification_bloc.dart';
import 'package:selling_food_store/modules/notification/bloc/notification_state.dart';
import 'package:selling_food_store/shared/widgets/items/item_notification.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          'notification'.tr(),
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) => Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => ItemNotification(
                            notify: state.notifications[index]),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: state.notifications.length),
                  )
                ],
              )),
    );
  }
}
