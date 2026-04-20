import 'package:flutter/material.dart';

String meetingDateButtonLabel(DateTime? date) {
  if (date == null) return '날짜';
  return '${date.month}.${date.day}';
}

String meetingTimeButtonLabel(TimeOfDay? time) {
  if (time == null) return '시간';
  return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
}
