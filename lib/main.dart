import 'package:flutter/material.dart';
import 'screens/learn_coins_screen.dart';
import 'screens/learn_bills_screen.dart';
import 'screens/play_coins_screen.dart';
import 'screens/play_bills_screen.dart';
import 'screens/quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Champions',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CurrencyChampionsHome(),
    );
  }
}

class CurrencyChampionsHome extends StatelessWidget {
  const CurrencyChampionsHome({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Currency Champions',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'serif',
                  color: Color(0xFFB54B3C),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: isTablet ? 600 : screenSize.width * 0.9,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildMenuButton(
                                'Learn about Coins',
                                Colors.lightGreen[100]!,
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LearnCoinsScreen()),
                                ),
                              ),
                              _buildMenuButton(
                                'Learn about Bills',
                                Colors.lightGreen[100]!,
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LearnBillsScreen()),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildMenuButton(
                                'Play with Coins',
                                Colors.lightGreen[100]!,
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PlayCoinsScreen()),
                                ),
                              ),
                              _buildMenuButton(
                                'Play with Bills',
                                Colors.lightGreen[100]!,
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PlayBillsScreen()),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildMenuButton(
                            'Take Quiz',
                            Color(0xFFE6C5B9),
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const QuizScreen()),
                            ),
                            width: 200,
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            height: 250,
                            width: double.infinity,
                            child: Image.asset(
                              'assets/home1.png',
                              fit: BoxFit.contain,
                              scale: 0.8,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(String text, Color color, VoidCallback onPressed, {double? width}) {
    return SizedBox(
      width: width ?? 180,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 3,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
