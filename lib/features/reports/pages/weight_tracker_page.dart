import 'package:diet_tracker/features/reports/widgets/profile_header.dart';
import 'package:diet_tracker/features/reports/widgets/results_list.dart';
import 'package:diet_tracker/features/reports/widgets/weight_graph.dart';
import 'package:flutter/material.dart';

class WeightTrackerPage extends StatefulWidget {
  const WeightTrackerPage({super.key});

  @override
  _WeightTrackerPageState createState() => _WeightTrackerPageState();
}

class _WeightTrackerPageState extends State<WeightTrackerPage> {
  final int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(),
            const SizedBox(height: 16),
            Expanded(
              flex: 2,
              child: WeightGraph(), // Graph Widget
            ),
            const SizedBox(height: 16),
            Expanded(
              flex: 3,
              child: ResultsList(), // Results List Widget
            ),
          ],
        ),
      ),
    );
  }
}
