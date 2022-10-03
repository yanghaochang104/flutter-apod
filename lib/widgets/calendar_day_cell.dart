import 'package:flutter/material.dart';

class CalendarDayCell extends StatefulWidget {
  const CalendarDayCell(
      {super.key,
      required this.day,
      this.decoration,
      this.hasDot = false,
      this.dotColor = Colors.red});

  final DateTime day;
  final Decoration? decoration;
  final bool hasDot;
  final Color dotColor;

  @override
  State<CalendarDayCell> createState() => _CalendarDayCellState();
}

class _CalendarDayCellState extends State<CalendarDayCell> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Container(
          width: 35.0,
          height: 35.0,
          padding: const EdgeInsets.all(5.0),
          decoration: widget.decoration,
          child: Center(
            child: Text(
              widget.day.day.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        widget.hasDot
            ? Container(
                width: 5.0,
                height: 5.0,
                decoration: BoxDecoration(
                  color: widget.dotColor,
                  shape: BoxShape.circle,
                ),
              )
            : Container(),
      ]),
    );
  }
}
