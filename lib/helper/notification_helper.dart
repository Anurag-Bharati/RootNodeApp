import 'package:awesome_notifications/awesome_notifications.dart';

class LocalNotificationHelper {
  static AwesomeNotifications? _instance;
  static AwesomeNotifications get awesomeNotification =>
      _instance ??= AwesomeNotifications();

  static void checkNotificationEnabled() {
    awesomeNotification.isNotificationAllowed().then((value) {
      if (value) {
        awesomeNotification.requestPermissionToSendNotifications();
      }
    });
  }
}
