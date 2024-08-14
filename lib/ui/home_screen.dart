import 'package:flutter/material.dart';
import '../result/result_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchQuery = '';
  String _contentType = 'movie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/apple_logo.jpeg', // Path to your Apple logo asset
                  height: 40, // Adjust the height as needed
                ),
                SizedBox(width: 10), // Space between logo and text
                Text(
                  'iTunes',
                  style: TextStyle(
                    fontSize: 28, // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Adjust the color based on your theme
                  ),
                ),
              ],
            ),
             SizedBox(height: 20),
            Text(
              'Search for a variety of content from the iTunes store including iBooks, movies, podcast, music, music videos, and audiobooks.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter search term',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: <Widget>[
                _buildChoiceChip('album'),
                _buildChoiceChip('movie'),
                _buildChoiceChip('musicVideo'),
                _buildChoiceChip('song'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      searchQuery: _searchQuery,
                      contentType: _contentType,
                    ),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _contentType == label,
      onSelected: (selected) {
        setState(() {
          _contentType = label;
        });
      },
    );
  }
}
