import 'package:flutter/material.dart';
import 'name_bill_game_screen.dart';
import 'value_bill_game_screen.dart';
import 'bill_conversion_game_screen.dart';

class PlayBillsScreen extends StatelessWidget {
  const PlayBillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  const Text(
                    'Bill Games',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB54B3C),
                    ),
                  ),
                  const Spacer(flex: 2),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildGameButton('Name the Bill', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NameBillGameScreen()),
                        );
                      }),
                      const SizedBox(height: 20),
                      _buildGameButton('Value of the Bill', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ValueBillGameScreen()),
                        );
                      }),
                      const SizedBox(height: 20),
                      _buildGameButton('Bill value conversion', () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BillConversionGameScreen()),
                        );
                      }),
                    ],
                  ),
                  const Spacer(flex: 3),
                  Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.home,
                        size: 40,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: const Icon(
                Icons.translate,
                size: 30,
                color: Colors.black87,
              ),
              onPressed: () {
                // Translation logic will be added later
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE6C5B9),
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 3,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
} 