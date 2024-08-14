import 'package:flutter/material.dart';
import 'package:itunes_search/ui/videoplayer_screen.dart';

class DetailScreen extends StatelessWidget {
  final Map item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['trackName'] ?? item['collectionName'] ?? 'No Title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  item['artworkUrl100'] ?? '',
                  height: 200,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Title: ${item['trackName'] ?? item['collectionName'] ?? 'No Title'}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Artist: ${item['artistName'] ?? 'Unknown Artist'}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Collection: ${item['collectionName'] ?? 'No Collection'}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Release Date: ${item['releaseDate'] != null ? item['releaseDate'].substring(0, 10) : 'No Date'}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              if (item['description'] != null || item['longDescription'] != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      item['description'] ?? item['longDescription'] ?? 'No Description Available',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              if (item['previewUrl'] != null)
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to VideoPlayerScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                            videoUrl: item['previewUrl'],
                            title: item['trackName'] ?? item['collectionName'] ?? 'No Title',
                          ),
                        ),
                      );
                    },
                    child: Text('Play Preview'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
