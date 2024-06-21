import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackController = TextEditingController();
  bool _isSent = false;

  Future<void> _submitFeedback() async {
    if (_formKey.currentState?.validate() ?? false) {
      String feedback = _feedbackController.text;
      setState(() {
        _isSent = false; // Reset the sent state
      });

      // Replace with your MongoDB server endpoint
      final Uri uri = Uri.parse('https://your-mongodb-server-endpoint.com/feedback');

      try {
        final response = await http.post(
          uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'feedback': feedback}),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // If the server returns an OK or Created response, display a confirmation.
          setState(() {
            _isSent = true; // Set to true to show "Feedback sent"
            _feedbackController.clear(); // Clear the text field
          });
        } else {
          // If the server returns an unexpected status code, handle the error.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send feedback: ${response.statusCode}')),
          );
        }
      } catch (e) {
        // If an error occurs, handle it appropriately.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _feedbackController,
                    decoration: InputDecoration(
                      labelText: 'Enter your feedback',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some feedback';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submitFeedback,
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            if (_isSent) // Show this text if feedback has been sent
              Text(
                'Feedback sent',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
