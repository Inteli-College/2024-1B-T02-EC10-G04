import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/logic/calendar_funcitons.dart';
import 'package:provider/provider.dart';
import 'package:mobile/widgets/date_picker.dart';

Widget buildCalendarSelector(BuildContext context) {
    var calendarLogic = Provider.of<CalendarLogic>(context);

    return Padding(
    padding: const EdgeInsets.only(right: 10.0, left: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat('MMMM yyyy').format(calendarLogic.selectedDate),
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20, 
            fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.filter_alt),
          onPressed: () => _showMonthYearPicker(context),
        ),
      ],
    )
    );
    
    
  }

  void _showMonthYearPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DatePicker();
      },
    );
  }

  Widget buildDaysCalendar(BuildContext context) {
    var calendarLogic = Provider.of<CalendarLogic>(context);

    return SizedBox(
      height: 65,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: calendarLogic.generateDays(() {
          calendarLogic.notifyListeners();
        }).length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 60,
            child: calendarLogic.generateDays(() {
              calendarLogic.notifyListeners();
            })[index],
          );
        },
      ),
    );
  }