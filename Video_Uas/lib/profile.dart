import 'package:flutter/material.dart';
import 'package:video_uas/main.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.lightBlue[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display profile picture (you can replace this with an actual image)
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.lightBlue[800],
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            // Display user name (you can replace this with actual data)
            Text(
              'Admin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue[800],
              ),
            ),
            SizedBox(height: 10),
            // Display user email (you can replace this with actual data)
            Text(
              'admin@admin.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.lightBlue[600],
              ),
            ),
            SizedBox(height: 20),
            // Log Out Button
            ElevatedButton(
              onPressed: () {
                // Implement logout functionality
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()), // Or navigate to the appropriate login page
                );
              },
              child: Text('Log Out'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
                backgroundColor: Colors.red[300], // Set the background color for the log out button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
