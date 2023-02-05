import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class LocalNotificationChannel {
  static NotificationChannel testChannel = NotificationChannel(
    channelGroupKey: 'test-group',
    channelDescription: 'Notification test using test channel',
    channelKey: 'test_channel',
    channelName: 'Test Notification',
    defaultColor: Colors.cyan,
    importance: NotificationImportance.Max,
    ledColor: Colors.amber,
    channelShowBadge: true,
  );
}
