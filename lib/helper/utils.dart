import 'package:timeago/timeago.dart' as timeago;

class Utils {
  static String getTimeAgo(DateTime dt) {
    Duration diff = DateTime.now().difference(dt);
    int min = diff.inMinutes;
    return timeago.format(DateTime.now().subtract(Duration(minutes: min)),
        locale: 'en_short');
  }
}
