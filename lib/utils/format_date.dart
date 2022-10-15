String formatDate(DateTime datetime) {
  String year = datetime.year.toString();
  String month =
      datetime.month < 10 ? '0${datetime.month}' : datetime.month.toString();
  String day = datetime.day < 10 ? '0${datetime.day}' : datetime.day.toString();
  return '$year-$month-$day';
}
