import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Hall {
  final String name;
  final String status;
  final List<DateTime> bookedDays;

  Hall({
    required this.name,
    required this.status,
    required this.bookedDays,
  });
}

class HallPage extends StatelessWidget {
  final List<Hall> halls = [
    Hall(
      name: 'Mini Hall 1',
      status: 'Booked',
      bookedDays: [
        DateTime.utc(2024, 8, 28), // Booked on 28th August
      ],
    ),
    Hall(
      name: 'Mini Hall 2',
      status: 'Not available',
      bookedDays: [],
    ),
    Hall(
      name: 'Peter Ducker Hall',
      status: 'Manual booking',
      bookedDays: [],
    ),
    Hall(
      name: 'Turing Hall',
      status: 'Booked',
      bookedDays: [
        DateTime.utc(2024, 6, 1),
        DateTime.utc(2024, 6, 10),
        DateTime.utc(2024, 6, 15),
      ],
    ),
    Hall(
      name: 'J.C. Bose Hall',
      status: 'Booked',
      bookedDays: [
        DateTime.utc(2024, 7, 4),
        DateTime.utc(2024, 7, 11),
        DateTime.utc(2024, 7, 18),
      ],
    ),
    Hall(
      name: 'Biotech Seminar Hall',
      status: 'Booked',
      bookedDays: [
        DateTime.utc(2024, 9, 1),
        DateTime.utc(2024, 9, 8),
        DateTime.utc(2024, 9, 15),
      ],
    ),
    Hall(
      name: 'G.D. Naidu Hall',
      status: 'Booked',
      bookedDays: [
        DateTime.utc(2024, 10, 5),
        DateTime.utc(2024, 10, 12),
        DateTime.utc(2024, 10, 19),
      ],
    ),
    Hall(
      name: 'Hippocrates Auditorium',
      status: 'Booked',
      bookedDays: [
        DateTime.utc(2024, 11, 1),
        DateTime.utc(2024, 11, 8),
        DateTime.utc(2024, 11, 15),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hall Availability'),
      ),
      body: ListView.builder(
        itemCount: halls.length,
        itemBuilder: (context, index) {
          final hall = halls[index];
          return ExpansionTile(
            title: Text(hall.name),
            subtitle: Text('Status: ${hall.status}'),
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Booked Days:'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: hall.bookedDays
                          .map((day) => Text('- ${day.day}/${day.month}/${day.year}'))
                          .toList(),
                    ),
                    SizedBox(height: 16),
                    Text('Calendar:'),
                    SizedBox(height: 8),
                    _buildCalendar(hall),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCalendar(Hall hall) {
    return TableCalendar(
      firstDay: DateTime.utc(2022, 1, 1), // Example first day
      lastDay: DateTime.utc(2025, 12, 31), // Example last day
      focusedDay: hall.bookedDays.isNotEmpty ? hall.bookedDays.first : DateTime.now(), // Use first booked day or current day if no bookings
      calendarFormat: CalendarFormat.month,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          //color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),
      selectedDayPredicate: (day) {
        return hall.bookedDays.any((bookedDay) =>
        bookedDay.day == day.day &&
            bookedDay.month == day.month &&
            bookedDay.year == day.year);
      },
    );
  }
}

