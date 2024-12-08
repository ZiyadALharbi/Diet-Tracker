import 'package:flutter/material.dart';

class ResultsList extends StatelessWidget {
  final List<Map<String, String>> results = [
    {'date': 'Jan 21, 2022', 'weight': '81.5 kg'},
    {'date': 'Aug 31, 2022', 'weight': '82 kg'},
    {'date': 'Jan 1, 2023', 'weight': '83.5 kg'},
    {'date': 'Nov 16, 2023', 'weight': '89.3 kg'},
    {'date': 'Feb 29, 2024', 'weight': '91 kg'},
  ];

   ResultsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return ListTile(
          title: Text(result['date']!),
          trailing: Text(result['weight']!),
        );
      },
    );
  }
}
