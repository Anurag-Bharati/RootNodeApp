import 'package:awesome_notifications/awesome_notifications.dart';

class LocalNotificationHelper {
  static AwesomeNotifications? _instance;
  static AwesomeNotifications get awesomeNotification =>
      _instance ??= AwesomeNotifications();

  static Future<AwesomeNotifications> checkNotificationEnabled() async {
    bool val = await awesomeNotification.isNotificationAllowed();
    if (!val) await awesomeNotification.requestPermissionToSendNotifications();
    return awesomeNotification;
  }
}
