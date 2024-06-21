import 'package:flutter/material.dart';
import 'package:alexa_internal/clubs.dart';
import 'package:alexa_internal/clubs_admin.dart'; // Import ClubsAdminPage
import 'package:alexa_internal/recruitements.dart';

class FirstPage extends StatelessWidget {
  // Controllers for username and password text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'), // Replace with your image path
            fit: BoxFit.cover, // Adjust the image fitting as needed
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Campus Pulse',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 55.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'By ByteBrigade',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              const SizedBox(height: 40.0),
              // Username text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Password text field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // Replace with your actual username and password validation logic
                  String username = _usernameController.text.trim();
                  String password = _passwordController.text.trim();

                  // Example validation logic
                  if (username == 'admin2' && password == 'admin1234') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClubsAdminPage()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClubsPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6E8CB6), // Button color
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Button border radius
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
