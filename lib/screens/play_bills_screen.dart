import 'package:flutter/material.dart';

class PlayBillsScreen extends StatelessWidget {
  const PlayBillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: const Center(child: Text('Play Bills Screen')),
      ),
    );
  }
} 