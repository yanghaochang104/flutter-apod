import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    DateTime current = DateTime.now();
    return Center(
        child: TableCalendar(
      firstDay: DateTime.utc(current.year - 2, 01, 01),
      lastDay: DateTime.utc(current.year + 2, 12, 31),
      focusedDay: DateTime.now(),
    ));
  }
}
