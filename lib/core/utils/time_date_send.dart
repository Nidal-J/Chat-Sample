import 'dart:developer';
import 'package:intl/intl.dart';

String timeSend(int msEpoch) {
  if (msEpoch != 0) {
    var format = DateFormat('h:mm a');
    log(format.toString());
    var time = format.format(DateTime.fromMillisecondsSinceEpoch(msEpoch));
    return time;
  }
  return '';
}

String dateSend(String dateSend) {
  var format = DateFormat('MM/dd/yyyy');
  log(format.toString());
  var time =
      format.format(DateTime.fromMillisecondsSinceEpoch(int.parse(dateSend)));
  return time;
}
