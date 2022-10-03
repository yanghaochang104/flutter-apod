import 'package:apod/widgets/astro_picture.dart';
import 'package:apod/widgets/calendar_day_cell.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime current = DateTime.now();
    return Center(
        child: TableCalendar(
            headerStyle: const HeaderStyle(formatButtonVisible: false),
            firstDay: DateTime.utc(current.year - 2, 01, 01),
            lastDay: DateTime.utc(current.year + 2, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay; // 選取的日期
                _focusedDay = focusedDay; // 頁面停留的日期
              });
            },
            onDayLongPressed: ((selectedDay, focusedDay) {
              // 長按日期時導向該日的天文圖片頁面
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Scaffold(
                    appBar: AppBar(
                        title: Text(
                            '${selectedDay.year}-${selectedDay.month}-${selectedDay.day}')),
                    body: const AstroPicture(
                        title: '',
                        pictureUrl: '',
                        desc: '',
                        note: '',
                        isFavorite: false));
              }));
            }),
            calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) =>
                    Center(child: CalendarDayCell(day: day)),
                selectedBuilder: (context, day, focusedDay) => Center(
                    child: CalendarDayCell(
                        day: day,
                        decoration: BoxDecoration(
                          color: Colors.blue[300],
                          shape: BoxShape.circle,
                        ))),
                todayBuilder: (context, day, focusedDay) => CalendarDayCell(
                    day: day,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      shape: BoxShape.circle,
                    )))));
  }
}
