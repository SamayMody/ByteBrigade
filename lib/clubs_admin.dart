import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'aboutclubs.dart';
import 'clubs_convenors.dart';
import 'feedback.dart';
import 'hall.dart';
import 'events_admin.dart';
import 'recruitements.dart';

class ClubsAdminPage extends StatefulWidget {
  @override
  _ClubsAdminPageState createState() => _ClubsAdminPageState();
}

class _ClubsAdminPageState extends State<ClubsAdminPage> {
  List<Map<String, dynamic>> clubs = [
    {
      'name': 'AlexaDevelopers',
      'image': 'assets/images/alexa.png',
      'description':
      'Powered by Amazon Alexa, we form the official Alexa Developers Club in SRMIST...',
      'type': 'Technical club',
    },
    {
      'name': 'GDSC',
      'image': 'assets/images/gdsc.png',
      'description':
      'Google Developer Student Club (GDSC) is a Google Developers program for university students...',
      'type': 'Technical club',
    },
    // Add more initial club data as needed
  ];

  String _newClubName = '';
  String _newClubDescription = '';
  File? _newClubImage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  void _navigateToScreen(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Club Management'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Clubs'),
              onTap: () {
                _navigateToScreen(context, '/aboutclubs');
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Clubs Convenors'),
              onTap: () {
                _navigateToScreen(context, '/clubsconvenors');
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedback'),
              onTap: () {
                _navigateToScreen(context, '/feedback');
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Hall Availability'),
              onTap: () {
                _navigateToScreen(context, '/hall');
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: clubs.length + 1, // +1 for the add club button
        itemBuilder: (context, index) {
          if (index == clubs.length) {
            return ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Club'),
              onTap: () {
                _showAddClubDialog();
              },
            );
          }

          final club = clubs[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: _getImageProvider(club['image']),
            ),
            title: Text(club['name']),
            subtitle: Text(club['description']),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editClub(club, index);
              },
            ),
            onLongPress: () {
              _showDeleteDialog(club, index);
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Clubs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Registration',
          ),
        ],
        currentIndex: 0, // Default index for active item
        selectedItemColor: Theme.of(context).primaryColor, // Color for selected item
        onTap: (int index) {
          switch (index) {
            case 1:
              _navigateToScreen(context, '/events_admins');
              break;
            case 2:
              _navigateToScreen(context, '/registrations');
              break;
          }
        },
      ),
    );
  }

  ImageProvider<Object>? _getImageProvider(dynamic image) {
    if (image is String) {
      return AssetImage(image);
    } else if (image is File) {
      return FileImage(image);
    } else {
      return null; // Handle other cases or null gracefully
    }
  }

  void _showAddClubDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Club'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  _selectImage();
                },
                child: _newClubImage != null
                    ? Image.file(
                  _newClubImage!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                )
                    : Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[200],
                  child: Icon(Icons.camera_alt, size: 50, color: Colors.grey[400]),
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Club Name',
                ),
                onChanged: (value) {
                  _newClubName = value;
                },
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                onChanged: (value) {
                  _newClubDescription = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addClub();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _newClubImage = File(pickedFile.path);
      });
    }
  }

  void _addClub() {
    if (_newClubName.isNotEmpty &&
        _newClubDescription.isNotEmpty &&
        _newClubImage != null) {
      setState(() {
        clubs.add({
          'name': _newClubName,
          'description': _newClubDescription,
          'image': _newClubImage,
          'type': 'Other', // You can add type if necessary
        });
        _nameController.clear();
        _descriptionController.clear();
        _newClubName = '';
        _newClubDescription = '';
        _newClubImage = null;
      });
    }
  }

  void _editClub(Map<String, dynamic> club, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Club'),
          content: Text('Form or UI for editing the club "${club['name']}" goes here.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Save edited club logic
                // Example: club['name'] = editedName;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(Map<String, dynamic> club, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Club'),
          content: Text('Are you sure you want to delete the club "${club['name']}"?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                // Delete club logic
                clubs.removeAt(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
