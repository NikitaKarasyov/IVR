DateTime toNormal(DateTime got) {
  int day = got.day;
  int month = got.month;
  int hour = got.hour;
  int minute = got.minute;
  return DateTime(month = month, day = day, minute = minute, hour = hour);
}
