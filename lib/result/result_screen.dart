import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../details/detail_screen.dart';  // Import the detail screen

class ResultScreen extends StatefulWidget {
  final String searchQuery;
  final String contentType;

  ResultScreen({required this.searchQuery, required this.contentType});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List _results = [];
  bool _isLoading = true;
  bool _isGrid = false;

  @override
  void initState() {
    super.initState();
    _fetchResults();
  }

  Future<void> _fetchResults() async {
    // Log the API URL
    final url =
        'https://itunes.apple.com/search?term=${widget.searchQuery}&entity=${widget.contentType}';
    print('Fetching data from: $url');
    
    final response = await http.get(Uri.parse(url));

    // Log the raw response
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      setState(() {
        _results = json.decode(response.body)['results'];
        _isLoading = false;

        // Log the parsed results
        print('Parsed results: $_results');
      });
    } else {
      // Handle API error
      print('Failed to load results');
      throw Exception('Failed to load results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iTunes'),
        actions: [
          if (kIsWeb)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _toggleLayout,
                child: Text(_isGrid ? 'Grid Layout' : 'List Layout'),
              ),
            ),
          if (!kIsWeb)
            IconButton(
              icon: Icon(_isGrid ? Icons.grid_on : Icons.list),
              onPressed: _toggleLayout,
            ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _results.isEmpty
              ? Center(child: Text('No results found.'))
              : _isGrid
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: kIsWeb ? 6 : 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _navigateToDetailScreen(index),
                          child: _buildGridItem(index),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _navigateToDetailScreen(index),
                          child: _buildListItem(index),
                        );
                      },
                    ),
    );
  }

  void _toggleLayout() {
    setState(() {
      _isGrid = !_isGrid;
    });
  }

  Widget _buildGridItem(int index) {
    final item = _results[index];
    return Card(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.network(item['artworkUrl100'] ?? '', fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              item['trackName'] ?? item['collectionName'] ?? 'No Title',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(int index) {
    final item = _results[index];
    return ListTile(
      leading: Image.network(item['artworkUrl100'] ?? ''),
      title: Text(item['trackName'] ?? item['collectionName'] ?? 'No Title'),
      subtitle: Text(item['artistName'] ?? ''),
    );
  }

  void _navigateToDetailScreen(int index) {
    final item = _results[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(item: item),
      ),
    );
  }
}
