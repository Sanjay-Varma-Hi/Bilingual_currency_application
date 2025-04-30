import 'package:flutter/material.dart';
import '../widgets/score_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ... existing code ...
          Positioned(
            top: 40,
            left: 20,
            child: const ScoreWidget(),
          ),
          // ... existing code ...
        ],
      ),
    );
  }
} 