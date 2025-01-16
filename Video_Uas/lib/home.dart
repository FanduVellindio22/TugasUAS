import 'package:flutter/material.dart';
import 'package:video_uas/profile.dart';
import 'action.dart';
import 'horror.dart';
import 'comedy.dart';
import 'romance.dart';
import 'thriller.dart';
import 'music.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> categories = [
    {'title': 'Action', 'icon': Icons.sports_kabaddi, 'page': ActionScreen()},
    {'title': 'Horror', 'icon': Icons.nightlight_round, 'page': HorrorScreen()},
    {'title': 'Comedy', 'icon': Icons.emoji_emotions, 'page': ComedyScreen()},
    {'title': 'Romance', 'icon': Icons.favorite, 'page': RomanceScreen()},
    {'title': 'Thriller', 'icon': Icons.warning, 'page': ThrillerScreen()},
    {'title': 'Music', 'icon': Icons.music_note, 'page': MusicScreen()},
  ];

  List<Map<String, dynamic>> filteredCategories = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCategories = categories; // Initialize with all categories
  }

  void _searchCategories() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredCategories = categories.where((category) {
        return category['title'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Admin',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Playfair Display',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue[300],
        elevation: 4,
        automaticallyImplyLeading: false, // Hides the back button
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => _searchCategories(), // Trigger search on text change
              decoration: InputDecoration(
                hintText: 'Search categories...',
                hintStyle: TextStyle(color: Colors.lightBlue[800]),
                prefixIcon: Icon(Icons.search, color: Colors.lightBlue[800]),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue[800]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue[800]!, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              padding: const EdgeInsets.all(8.0),
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => filteredCategories[index]['page'],
                      ),
                    );
                  },
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.lightBlue[50],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          filteredCategories[index]['icon'],
                          size: 60,
                          color: Colors.lightBlue[800],
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          filteredCategories[index]['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: Text(
                'Profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue[300], // Specify background color
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
