import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sim_flights_tracker/core/config/router_config.dart';
import 'package:sim_flights_tracker/core/constants/app_routes.dart';
import 'package:sim_flights_tracker/core/state/model/notifications_state.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as timezone;

import '../../../data/entity/_sft_event.dart';
import '../../../presentation/util/general_utils.dart';
import '../../theme/colors.dart';

class NotificationsStateNotifier extends Notifier<NotificationsState> {
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  static const NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails('SimFlightsTracker', 'events',
      importance: Importance.high,
      priority: Priority.high,
      color: SftColors.primaryDark,
    ),
    iOS: DarwinNotificationDetails(),
  );

  @override
  NotificationsState build() => NotificationsState();

  void updateMinutesBeforeReminder(int minutes) {
    state = state.copyWith(minutesBeforeReminder: minutes);
  }

  Future<void> _fetchPendingNotifications() async {
    var pendingNotifications = await _localNotifications.pendingNotificationRequests();

    state = state.copyWith(pendingNotifications: pendingNotifications);
  }

  Future<void> deletePendingNotification(int notificationId, [bool showNotification = true]) async {
    await _localNotifications.cancel(notificationId);
    await _fetchPendingNotifications();

    if (showNotification) showSnackBarNotification('Event reminder has been removed.');
  }

  Future<void> showInstantNotification(String title, String message, int notificationId) async {
    await _localNotifications.show(notificationId, title, message, notificationDetails, payload: notificationId.toString());
  }

  Future<void> scheduleNotification(String title, String message, DateTime date, SftEvent event, [int notificationId = 12]) async {
    tz.initializeTimeZones();

    //  remove reminder minutes from date;
    var reminderDate = date.subtract(Duration(minutes: state.minutesBeforeReminder));

    await _localNotifications.zonedSchedule(
        notificationId,
        title,
        message,
        timezone.TZDateTime.from(reminderDate, timezone.local),
        notificationDetails,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        payload: reminderDate.millisecondsSinceEpoch.toString(),
        androidScheduleMode: AndroidScheduleMode.exact
    );

    await _fetchPendingNotifications();

    showSnackBarNotification('Reminder has been set for this event.');
    state = state.copyWith(minutesBeforeReminder: 15);
  }

  Future<bool> _clearPastNotifications() async {
    var millisecondsNow = DateTime.now().millisecondsSinceEpoch;

    for (var notification in state.pendingNotifications) {
      if (notification.payload != null) {
        var notificationMilliseconds = num.parse(notification.payload!);

        if (notificationMilliseconds <= millisecondsNow) {
          await deletePendingNotification(notification.id, false);
        }
      }
    }

    return true;
  }

  Future<void> initLocalNotifications() async {
    //  Android notification settings;
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('sft_transparent');

    //  iOS notification settings;
    const DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings();

    //  load init settings;
    const InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings
    );

    //  init the local notifications plugin;
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        AppRouter.router.pushNamed(AppRoutes.eventsHomeScreenNamed);
      }
    );

    //  request android permission;
    await _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _fetchPendingNotifications();
    await _clearPastNotifications();
  }
}