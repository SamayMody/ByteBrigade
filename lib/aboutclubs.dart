import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutClubsPage extends StatelessWidget {
  final Uri _moreInfoUrl = Uri.parse('https://www.srmist.edu.in/life-at-srm/student-life/clubs/');

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'), // Ensure 'bg.png' is in 'assets/images/'
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'The SRM Institute of Science and Technology does not limit learning to textbooks and focuses on the holistic development of its students beyond the four walls of the classrooms! The students are offered opportunities to hone their skills and learn new skills through workshops, sessions and activities which are organised by the clubs. These activities promote students to experiment with their innate potential in a favourable ambience. Joining a club is easy and makes life more rewarding, stimulating and most importantly, fun. It gives students an opportunity to find people with similar interests and passions and allows them to foster them enthusiastically. SRMIST aims at building local and intercultural relationships between students, as well as their own identities, which promotes their well-being and performance over time and broadens their worldview because the mark of true education is the ability to shape students to be better human beings!',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _launchInBrowser(_moreInfoUrl),
                      child: Text(
                        'Click here to learn more',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
