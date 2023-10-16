import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final List<Map<String, dynamic>> maps = [
    {'name': 'John Doe', 'age': 30},
    {'name': 'Jane Doe', 'age': 25},
    {'name': 'Peter Parker', 'age': 20},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search Example'),
        ),
        body: SearchWidget(maps: maps),
      ),
    );
  }
}

class SearchWidget extends StatefulWidget {
  final List<Map<String, dynamic>> maps;

  const SearchWidget({Key? key, required this.maps}) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      _updateSearchResults();
    });
  }

  void _updateSearchResults() {
    final searchQuery = _searchController.text;

    _searchResults = widget.maps.where((map) {
      return map.keys.any((key) => map[key].toString().contains(searchQuery));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(hintText: 'Search'),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            final map = _searchResults[index];

            return ListTile(
              title: Text(map.keys.first),
              subtitle: Text(map.values.first.toString()),
            );
          },
        ),
      ],
    );
  }
}
