import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:intl/intl.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String _selectedLocation = 'All';

  // Registration URL for all events
  final Uri registerUrl = Uri.parse(
    'https://docs.google.com/forms/d/e/1FAIpQLSf4OXBSccE2zxZQqeccKTYxws7uU3ewBsb4wT9G8uczjH_85w/viewform?usp=pp_url',
  );

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launcher.launch(
      url.toString(),
      forceSafariVC: false,
      forceWebView: false,
      enableJavaScript: true,
      enableDomStorage: true,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  // Method to launch Google Maps with the selected location
  Future<void> _launchMap(String location) async {
    final query = Uri.encodeComponent(location);
    final url = 'https://www.google.com/maps/search/?api=1&query=$query';
    if (await launcher.canLaunch(url)) {
      await launcher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Method to get and filter valid events
  List<EventCard> getValidEvents() {
    DateTime now = DateTime.now();

    // List of events with their details
    List<EventCard> events = [
      EventCard(
        title: 'Hackathon 2024',
        date: 'June 25, 2024',
        time: '10:00 AM - 10:00 PM',
        location: 'Mini Hall 1',
        description:
        'A 24-hour coding marathon where developers come together to build innovative solutions.',
        registerUrl: registerUrl,
        onLaunch: _launchInBrowser,
        onLocationTap: _launchMap,
      ),
      EventCard(
        title: 'Tech Conference',
        date: 'July 10, 2024',
        time: '9:00 AM - 5:00 PM',
        location: 'Mini Hall 2',
        description:
        'A conference showcasing the latest trends in technology and innovation.',
        registerUrl: registerUrl,
        onLaunch: _launchInBrowser,
        onLocationTap: _launchMap,
      ),
      EventCard(
        title: 'AI Workshop',
        date: 'June 18, 2024', // Example of a past event
        time: '10:00 AM - 4:00 PM',
        location: 'Peter Ducker Hall',
        description: 'A workshop on the basics of Artificial Intelligence.',
        registerUrl: registerUrl,
        onLaunch: _launchInBrowser,
        onLocationTap: _launchMap,
      ),
      EventCard(
        title: 'Developer Meetup',
        date: 'June 20, 2024', // New event
        time: '08:20 PM - 08:43 PM',
        location: 'Turing Hall',
        description:
        'An evening meetup for developers to network and share their experiences.',
        registerUrl: registerUrl,
        onLaunch: _launchInBrowser,
        onLocationTap: _launchMap,
      ),
      EventCard(
        title: 'Tech Seminar',
        date: 'June 30, 2024',
        time: '1:00 PM - 4:00 PM',
        location: 'J.C. Bose Hall',
        description: 'A seminar focusing on emerging technologies.',
        registerUrl: registerUrl,
        onLaunch: _launchInBrowser,
        onLocationTap: _launchMap,
      ),
      EventCard(
        title: 'Biotech Conference',
        date: 'July 5, 2024',
        time: '10:00 AM - 6:00 PM',
        location: 'Biotech Seminar Hall',
        description: 'Conference discussing advances in biotechnology.',
        registerUrl: registerUrl,
        onLaunch: _launchInBrowser,
        onLocationTap: _launchMap,
      ),
      EventCard(
        title: 'Innovation Summit',
        date: 'July 15, 2024',
        time: '9:00 AM - 5:00 PM',
        location: 'G.D.Naidu Hall',
        description: 'Summit showcasing innovations across industries.',
        registerUrl: registerUrl,
        onLaunch: _launchInBrowser,
        onLocationTap: _launchMap,
      ),
      EventCard(
        title: 'Healthcare Symposium',
        date: 'July 20, 2024',
        time: '10:00 AM - 3:00 PM',
        location: 'Hippocrates Auditorium',
        description:
        'Symposium focusing on healthcare challenges and solutions.',
        registerUrl: registerUrl,
        onLaunch: _launchInBrowser,
        onLocationTap: _launchMap,
      ),
    ];

    // Filter out past events and apply location filter
    events = events.where((event) {
      DateTime eventEndDateTime = DateFormat('MMMM d, yyyy h:mm a')
          .parse('${event.date} ${event.time.split('-')[1].trim()}');
      bool isAfterNow = eventEndDateTime.isAfter(now);
      bool matchesLocation =
          _selectedLocation == 'All' || event.location == _selectedLocation;
      return isAfterNow && matchesLocation;
    }).toList();

    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Filter by Location:',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 8.0),
                  DropdownButton<String>(
                    value: _selectedLocation,
                    dropdownColor: Colors.grey[800],
                    style: TextStyle(color: Colors.white),
                    items: <String>[
                      'All',
                      'Mini Hall 1',
                      'Mini Hall 2',
                      'Peter Ducker Hall',
                      'Turing Hall',
                      'J.C. Bose Hall',
                      'Biotech Seminar Hall',
                      'G.D.Naidu Hall',
                      'Hippocrates Auditorium',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedLocation = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: getValidEvents(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String description;
  final Uri registerUrl;
  final void Function(Uri) onLaunch;
  final void Function(String) onLocationTap;

  EventCard({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.registerUrl,
    required this.onLaunch,
    required this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.grey[200], // Grey background color
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              date,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              time,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 4.0),
            InkWell(
              onTap: () {
                onLocationTap(location);
              },
              onLongPress: () {
                onLocationTap(location);
              },
              child: Text(
                location,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () => onLaunch(registerUrl),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                icon: Icon(Icons.event, color: Colors.white),
                label: Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
