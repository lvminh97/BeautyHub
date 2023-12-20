import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_food_store/modules/notification/bloc/notification_state.dart'
    as notification;

class NotificationBloc extends BlocBase<notification.NotificationState> {
  List<notification.Notification> notificationList = [];
  NotificationBloc() : super(const notification.NotificationState([])) {
    initData();
  }

  void initData() {
    notificationList = [
      notification.Notification('Khuyễn mãi', 'Mã giảm giá 50% tung hàng loạt',
          Icons.discount_outlined, 0),
      notification.Notification(
          'Live & Video', 'DEAL HOT CUỐI NGÀY', Icons.assignment_outlined, 1),
      notification.Notification(
          'Thông tin Tài chính',
          'Cơ hội lấy Voucher lên đến 100k cho mỗi ngày đăng nhập làm nhiệm vụ',
          Icons.local_atm_outlined,
          2),
      notification.Notification(
          'Cập nhật',
          'Hãy mời bạn bè cùng tham gia để cùng nhau săn sale thôi nào.',
          Icons.local_atm_outlined,
          3),
      notification.Notification(
          'Giải thưởng',
          'Bạn thân iu ơi. Vào app nhận thưởng thôi nà.',
          Icons.style_outlined,
          4),
    ];
    emit(notification.NotificationState(notificationList));
  }
}
