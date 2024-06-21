import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class GDSCPage extends StatelessWidget {
  final Uri applyUrl = Uri.parse(
    'https://docs.google.com/forms/d/e/1FAIpQLSf4OXBSccE2zxZQqeccKTYxws7uU3ewBsb4wT9G8uczjH_85w/viewform?usp=pp_url',
  );

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
        title: Text('Google Developer Student Club (GDSC)'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/images/gdsc.png'),
              SizedBox(height: 16.0),
              Text(
                'Google Developer Student Club (GDSC)',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Description',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Google Developer Student Club (GDSC) is a Google Developers program for university students to learn mobile and web development skills. The club will be open to any student, ranging from novice developers who are just starting, to advanced developers who want to further their skills. The club is intended as a space for students to try out new ideas and collaborate to solve mobile and web development problems.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                'Google Developer Clubs can take many forms - from just a few people getting together to watch some videos, to large gatherings with demos, tech talks, hackathons and conferences. We work on various technical domains and try to make use of Google Technologies to empower the audience around us.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Projects',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                '1. Google Cloud Study Jam:',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'Google Cloud Study Jam, provided the gateway to mastering Google Cloud Platform. Participants whether a coding whiz, data enthusiast, or simply curious about cloud, experienced interactive learning, expert mentorship, and real projects. They were given a one-month access to the Google Cloud Skills Boost platform as part of the jam-packed experience!',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                '2. Code with Node.js 2.0:',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'An event where participants were taught about the benefits of using Node.js - the JavaScript runtime that\'s the bee\'s knees for building speedy and efficient network apps!',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Social Media Links',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  socialMediaLink('Website', 'https://gdscsrm.com/', FeatherIcons.globe),
                  socialMediaLink('Instagram', 'https://www.instagram.com/gdsc.srm/', FeatherIcons.instagram),
                  socialMediaLink('LinkedIn', 'https://www.linkedin.com/company/gdscsrm/', FeatherIcons.linkedin),
                ],
              ),
              SizedBox(height: 24.0),
              Text(
                'Registrations',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              RegistrationListing(
                title: 'Technical Member',
                yearEligibility: '1st and 2nd Year',
                applyUrl: applyUrl,
                onLaunch: _launchInBrowser,
              ),
              RegistrationListing(
                title: 'Creatives',
                yearEligibility: '1st and 2nd Year',
                applyUrl: applyUrl,
                onLaunch: _launchInBrowser,
              ),
              RegistrationListing(
                title: 'Business',
                yearEligibility: '2nd and 3rd Year',
                applyUrl: applyUrl,
                onLaunch: _launchInBrowser,
              ),
              SizedBox(height: 16.0),
              buildApplySection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget socialMediaLink(String name, String url, IconData icon) {
    return InkWell(
      onTap: () async {
        if (!await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        )) {
          throw Exception('Could not launch $url');
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20.0,
            ),
            SizedBox(width: 8.0),
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildApplySection() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          onTap: () async {
            await _launchInBrowser(applyUrl);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Apply',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8.0),
              Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationListing extends StatelessWidget {
  final String title;
  final String yearEligibility;
  final Uri applyUrl;
  final Future<void> Function(Uri) onLaunch;

  const RegistrationListing({
    required this.title,
    required this.yearEligibility,
    required this.applyUrl,
    required this.onLaunch,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            yearEligibility,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement save functionality
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey.withOpacity(0.4),
                ),
                child: const Text('Save Link'),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () => onLaunch(applyUrl),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Launch in browser'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
