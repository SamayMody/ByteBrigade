import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Event {
  final String title;
  final String date;
  final String time;
  final String location;
  final String description;

  Event({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
  });
}

class EventsAdminPage extends StatefulWidget {
  @override
  _EventsAdminPageState createState() => _EventsAdminPageState();
}

class _EventsAdminPageState extends State<EventsAdminPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String? _selectedLocation; // Changed to nullable type
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> locations = [
    'Mini Hall 1',
    'Mini Hall 2',
    'Peter Drucker Hall',
    'Turing Hall',
    'J.C. Bose Hall',
    'Biotech Seminar Hall',
    'G.D. Naidu Hall',
    'Hippocrates Auditorium',
  ];

  List<Event> events = [
    Event(
      title: 'Git Workshop',
      date: 'July 15, 2024',
      time: '2:00 PM - 4:00 PM',
      location: 'Mini Hall 1',
      description: 'Description for existing event 1.',
    ),
    Event(
      title: 'AI Workshop',
      date: 'August 20, 2024',
      time: '10:00 AM - 12:00 PM',
      location: 'Turing Hall',
      description: 'Description for existing event 2.',
    ),
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _removePastEvents();
  }

  void _addEvent() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        events.add(Event(
          title: _titleController.text,
          date: _dateController.text,
          time: _timeController.text,
          location: _selectedLocation!,
          description: _descriptionController.text,
        ));

        _titleController.clear();
        _dateController.clear();
        _timeController.clear();
        _selectedLocation = null; // Reset to null after adding an event
        _descriptionController.clear();
      });

      Navigator.of(context).pop(); // Close the bottom sheet
    }
  }

  String? _validateDate(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a date';
    }
    try {
      DateFormat('MMMM d, yyyy').parse(value);
    } catch (e) {
      return 'Invalid date format (e.g. June 25, 2024)';
    }
    return null;
  }

  String? _validateTime(String? value) {
    if (value!.isEmpty) {
      return 'Please enter time';
    }
    RegExp timeRegExp = RegExp(r'^(1[0-2]|0?[1-9]):([0-5]?[0-9]) (AM|PM)$');
    if (!timeRegExp.hasMatch(value)) {
      return 'Invalid time format (e.g. 10:00 AM)';
    }
    return null;
  }

  void _removePastEvents() {
    setState(() {
      events.removeWhere((event) {
        DateTime eventEndDateTime = DateFormat('MMMM d, yyyy h:mm a').parse(
            '${event.date} ${event.time.split('-')[1].trim()}');
        return eventEndDateTime.isBefore(DateTime.now());
      });
    });
  }

  void _showAddEventSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add New Event',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Event Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Date (e.g. June 25, 2024)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: _validateDate,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _timeController,
                    decoration: InputDecoration(
                      labelText: 'Time (e.g. 10:00 AM)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: _validateTime,
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: _selectedLocation,
                    items: locations.map((String location) {
                      return DropdownMenuItem<String>(
                        value: location,
                        child: Text(location),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLocation = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Select Location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a location';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _addEvent,
                    child: Text('Add Event'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _removePastEvents(); // Ensure past events are removed each time the widget is built

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events Admin'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: events.map((event) {
                      return Card(
                        color: Colors.white.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 6.0,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.title,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                '${event.date} • ${event.time}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                event.location,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                event.description,
                                style: TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventSheet,
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
