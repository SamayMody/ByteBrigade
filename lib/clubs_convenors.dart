import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubsConvenorsPage extends StatelessWidget {
  final List<Map<String, dynamic>> convenors = [
    {
      'clubName': 'Creative Arts',
      'members': [
        {'name': 'Pranjal Shukla', 'department': 'Biomedical', 'contact': '9838592111'},
        {'name': 'Ankita Sarkar', 'department': 'Biotechnology', 'contact': '8104715943'},
        {'name': 'Sandeepan Karak', 'department': 'DSBS', 'contact': '7070049763'},
      ],
    },
    {
      'clubName': 'Dance',
      'members': [
        {'name': 'Anisha Sahay', 'department': 'CSE', 'contact': '9611572050'},
        {'name': 'Bala Sai Hitesh', 'department': 'CSE', 'contact': '7730015839'},
        {'name': 'Anukanksha Aashi', 'department': 'CSE CORE', 'contact': '8252610689'},
        {'name': 'Balaji', 'department': 'LLB', 'contact': '9677282223'},
      ],
    },
    {
      'clubName': 'Fashion',
      'members': [
        {'name': 'Yamin Khursheed', 'department': 'CSE Core', 'contact': '8082693874'},
        {'name': 'Maitreyee Joshi', 'department': 'CSE', 'contact': '9799438630'},
        {'name': 'Tarun Negi', 'department': 'CINTEL', 'contact': '7985857522'},
        {'name': 'Jigyasa Sharma', 'department': 'CSE Core', 'contact': '8868013407'},
        {'name': 'Riya Kumari', 'department': 'MBA', 'contact': '6369660348'},
      ],
    },
    {
      'clubName': 'Sports',
      'members': [
        {'name': 'Kosuru Somendra Sai', 'department': 'DSBS', 'contact': '6305275312'},
        {'name': 'Surya Bala S', 'department': 'MBA', 'contact': '9677568430'},
        {'name': 'Kester Elwin Abishek', 'department': 'MBA', 'contact': '8760296295'},
        {'name': 'Simma Sandeep', 'department': 'MBA', 'contact': '9123518662'},
      ],
    },
    {
      'clubName': 'Gaming',
      'members': [
        {'name': 'Uttam Kumawath', 'department': 'Pharmacy', 'contact': '9840159187'},
        {'name': 'Anant Agarwal', 'department': 'NWC', 'contact': '9831805637'},
      ],
    },
    {
      'clubName': 'Literary',
      'members': [
        {'name': 'Haya Naaz', 'department': 'Law', 'contact': '8601449248'},
        {'name': 'Urnava Goswami', 'department': 'CTech', 'contact': '9088663600'},
        {'name': 'Aadya Dixit', 'department': 'CSE Core', 'contact': '9340666541'},
      ],
    },
    {
      'clubName': 'Movie and Dramatics',
      'members': [
        {'name': 'Siddharth S', 'department': 'CINTEL', 'contact': '6369690264'},
        {'name': 'Harsha Malla', 'department': 'CSE Core', 'contact': '8017264613'},
        {'name': 'Kondapalli Abhiram', 'department': 'CSE CORE', 'contact': '8008133375'},
      ],
    },
    {
      'clubName': 'Women Empowerment',
      'members': [
        {'name': 'Debosmita Sarkar', 'department': 'CSE Core', 'contact': '7320007195'},
        {'name': 'Akalya.R', 'department': 'Biotechnology', 'contact': '7695847035'},
      ],
    },
    {
      'clubName': 'Self Defence',
      'members': [
        {'name': 'Serin Saj', 'department': 'CSE Core', 'contact': '9560776588'},
      ],
    },
    {
      'clubName': 'Music',
      'members': [
        {'name': 'Shreyans Bhargava', 'department': 'ECE', 'contact': '7062165721'},
        {'name': 'Srishti Chauhan', 'department': 'DSBS', 'contact': '7078517756'},
        {'name': 'Agnivyas Thumbayil', 'department': 'MBBS', 'contact': '9567087996'},
        {'name': 'Soham Bhattacharya', 'department': 'NWC', 'contact': '9987874594'},
      ],
    },
    {
      'clubName': 'Festival',
      'members': [
        {'name': 'G.S Sherlin Mercy', 'department': 'BA English', 'contact': '6369617709'},
        {'name': 'Yoga Selva S P', 'department': 'Dental', 'contact': '7598637027'},
        {'name': 'Shantanu Deshmukh', 'department': 'Mechanical', 'contact': '9146375708'},
      ],
    },
    {
      'clubName': 'Social',
      'members': [
        {'name': 'M. Sulaiman', 'department': 'MBBS', 'contact': '8270717207'},
      ],
    },
    {
      'clubName': 'Rotaract',
      'members': [
        {'name': 'Kanav Malhotra', 'department': 'CSE CI', 'contact': '8287088843'},
        {'name': 'Jemina J', 'department': 'Genetics', 'contact': '9360371807'},
      ],
    },
    {
      'clubName': 'Rubik\'s',
      'members': [
        {'name': 'Shubham Gusain', 'department': 'DSBS', 'contact': '7722071511'},
        {'name': 'Prem Mudit Chinni', 'department': 'ECE', 'contact': '7907374303'},
      ],
    },
    {
      'clubName': 'Quiz',
      'members': [
        {'name': 'Kumar Parth', 'department': 'ECE', 'contact': '7004070157'},
        {'name': 'Prathu Vijayvargiya', 'department': 'CSE', 'contact': '8109377037'},
      ],
    },
    {
      'clubName': 'Astrophilia',
      'members': [
        {'name': 'Bhumika Sharma', 'department': 'NWC - CSE-IOT', 'contact': '8310541255'},
        {'name': 'TANISHQ DHAWAN', 'department': 'CSE (AI&ML)', 'contact': '9621787447'},
        {'name': 'Ujjwal Pradeshi', 'department': 'NWC-CSE-IOT', 'contact': '8976131401'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clubs Convenors'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'), // Ensure 'bg.png' is in 'assets/images/'
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: convenors.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white.withOpacity(0.8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ExpansionTile(
                title: Text(
                  convenors[index]['clubName'],
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: List<Widget>.generate(
                  convenors[index]['members'].length,
                      (memberIndex) {
                    final member = convenors[index]['members'][memberIndex];
                    return ListTile(
                      title: Text(member['name']),
                      subtitle: GestureDetector(
                        onTap: () async {
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: member['contact'],
                          );
                          if (await canLaunchUrl(launchUri)) {
                            await launchUrl(launchUri);
                          } else {
                            throw 'Could not launch $launchUri';
                          }
                        },
                        child: Text(
                          '${member['department']} - ${member['contact']}',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
