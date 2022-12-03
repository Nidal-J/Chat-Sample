import 'package:intl/intl.dart';

String timeSend(String timeSend) {
  return DateFormat('h:mm a')
      .format(DateTime.fromMillisecondsSinceEpoch(int.parse(timeSend)));
  // final timeFormat = DateFormat('h:mm a');
  // final time = timeFormat.format(DateTime.fromMillisecondsSinceEpoch(msEpoch));
  // return time;
}

String dateSend(String dateSend) {
  return '';
  // final dateFormat = DateFormat('MM/dd/yyyy');
  // final time = dateFormat
  //     .format(DateTime.fromMillisecondsSinceEpoch(int.parse(dateSend)));
  // return time;
}
