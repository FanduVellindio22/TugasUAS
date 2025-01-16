import 'package:flutter/material.dart';
import 'login.dart';
import 'login_admin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Streaming App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Streaming App'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,  // No shadow for a cleaner look
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Deskripsi mengenai "Streaming Video"
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                'Welcome to the Video Streaming App!\n\n'
                    'Here, you can enjoy a wide variety of videos. '
                    'Sign in to get started and watch the content you love.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),

            // Button for Login with icon
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to the LoginScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              icon: Icon(
                Icons.login,  // Login icon
                size: 24,
                color: Colors.white,
              ),
              label: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
            ),
            SizedBox(height: 20),

            // Button for Admin Login with icon
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to the Admin Login screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginAdminScreen()),
                );
              },
              icon: Icon(
                Icons.admin_panel_settings,  // Admin icon
                size: 24,
                color: Colors.white,
              ),
              label: Text(
                'Login Admin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                backgroundColor: Colors.blue[700],  // Using blue[700] for a different look
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
