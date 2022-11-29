import 'package:intl/intl.dart';

String timeSend(int msEpoch) {
  final timeFormat = DateFormat('h:mm a');
  final time = timeFormat.format(DateTime.fromMillisecondsSinceEpoch(msEpoch));
  return time;
}

String dateSend(String dateSend) {
  final dateFormat = DateFormat('MM/dd/yyyy');
  final time = dateFormat
      .format(DateTime.fromMillisecondsSinceEpoch(int.parse(dateSend)));
  return time;
}
