import 'package:flutter/material.dart';

import 'package:selling_food_store/modules/notification/bloc/notification_state.dart'
    as notification;
import 'package:selling_food_store/shared/utils/app_utils.dart';

class ItemNotification extends StatelessWidget {
  final notification.Notification notify;
  const ItemNotification({super.key, required this.notify});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(width: 0.5, color: Colors.grey)),
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          notify.icon,
          color: AppUtils.generateIconColor(notify.type),
        ),
      ),
      title: Text(
        notify.title,
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        notify.subtitle,
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black26,
        ),
      ),
    );
  }
}
