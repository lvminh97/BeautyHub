import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NotificationState extends Equatable {
  final List<Notification> notifications;

  const NotificationState(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class Notification {
  final String title;
  final String subtitle;
  final IconData icon;
  final int type;

  Notification(
    this.title,
    this.subtitle,
    this.icon,
    this.type,
  );
}
