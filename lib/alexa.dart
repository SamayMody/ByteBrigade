import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class AlexaPage extends StatelessWidget {
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
        title: Text('Alexa Developers Club'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/images/alexa.png'),
              SizedBox(height: 16.0),
              Text(
                'Alexa Developers Club',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                'Description',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Known for edge-of-the-seat events, our aim is to resonate with a coterie of developers. Powered by Amazon Alexa, we form the official Alexa Developers Club in SRMIST. Committed to the services, we engage in workshops and events to build a community of Voice First Developers.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                'Our goal is to build a community of Voice First developers through Alexa Skills Workshops, Events, and many more. Join us for an amazing experience on Amazon\'s Virtual Assistant Alexa.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Projects',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                '1. Alexa-dev-mailer:',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'A CLI based mailer, leveraging the power of Amazon SES.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                '2. Zombie-Fever:',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'An Alexa game built using Skill Flow Builder. Check out the game here. Just ask Alexa to start Zombie Fever and get started.',
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
                  socialMediaLink('Instagram', 'https://www.instagram.com/alexadevsrm/', FeatherIcons.instagram),
                  socialMediaLink('GitHub', 'https://github.com/AlexaSRM', FeatherIcons.github),
                  socialMediaLink('LinkedIn', 'https://www.linkedin.com/company/alexa-developers-srm', FeatherIcons.linkedin),
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
              JobListing(
                jobTitle: 'Technical Member',
                eligibility: '1st and 2nd year students can apply',
                applyUrl: applyUrl,
                onLaunch: _launchInBrowser,
              ),
              JobListing(
                jobTitle: 'Creatives',
                eligibility: 'All years can apply',
                applyUrl: applyUrl,
                onLaunch: _launchInBrowser,
              ),
              JobListing(
                jobTitle: 'Business',
                eligibility: '2nd and 3rd year students can apply',
                applyUrl: applyUrl,
                onLaunch: _launchInBrowser,
              ),
              SizedBox(height: 16.0),
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
}

class JobListing extends StatelessWidget {
  final String jobTitle;
  final String eligibility;
  final Uri applyUrl;
  final Future<void> Function(Uri) onLaunch;

  const JobListing({
    required this.jobTitle,
    required this.eligibility,
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
            jobTitle,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            eligibility,
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
                onPressed: () => onLaunch(applyUrl),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
