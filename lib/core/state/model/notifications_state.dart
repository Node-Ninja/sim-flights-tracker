import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsState {
  final int minutesBeforeReminder;
  final List<PendingNotificationRequest> pendingNotifications;

  const NotificationsState({
    this.minutesBeforeReminder = 15,
    this.pendingNotifications = const [],
  });

  NotificationsState copyWith({
    int? minutesBeforeReminder,
    List<PendingNotificationRequest>? pendingNotifications,
  }) {
    return NotificationsState(
      minutesBeforeReminder: minutesBeforeReminder ?? this.minutesBeforeReminder,
      pendingNotifications: pendingNotifications ?? this.pendingNotifications,
    );
  }
}