import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = [
      {'name': 'Alice', 'age': 25},
      {'name': 'Bob', 'age': 30},
      {'name': 'Charlie', 'age': 22},
      // ... other map entries
    ];

    List<Map<String, dynamic>> filteredData =
        data.where((entry) => entry['age'] > 25).toList();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Filtered Data'),
        ),
        body: Column(
          children: [
            Text('Original Data:'),
            for (var entry in data) Text('${entry['name']} - ${entry['age']}'),
            Text('Filtered Data:'),
            for (var entry in filteredData)
              Text('${entry['name']} - ${entry['age']}'),
          ],
        ),
      ),
    );
  }
}
