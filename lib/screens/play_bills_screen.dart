import 'package:flutter/material.dart';
import 'name_bill_game_screen.dart';
import 'value_bill_game_screen.dart';
import 'bill_conversion_game_screen.dart';

class PlayBillsScreen extends StatefulWidget {
  const PlayBillsScreen({super.key});

  @override
  State<PlayBillsScreen> createState() => _PlayBillsScreenState();
}

class _PlayBillsScreenState extends State<PlayBillsScreen> {
  bool isSpanish = false;

  final Map<String, String> translations = {
    'Bill Games': 'Juegos de Billetes',
    'Name the Bill': 'Nombra el Billete',
    'Value of the Bill': 'Valor del Billete',
    'Bill value conversion': 'Conversión de valor de billetes',
  };

  String translate(String text) {
    if (!isSpanish) return text;
    return translations[text] ?? text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Spacer(flex: 2),
              Text(
                translate('Bill Games'),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB54B3C),
                ),
              ),
              const Spacer(flex: 2),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGameButton(translate('Name the Bill'), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NameBillGameScreen()),
                    );
                  }),
                  const SizedBox(height: 20),
                  _buildGameButton(translate('Value of the Bill'), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ValueBillGameScreen()),
                    );
                  }),
                  const SizedBox(height: 20),
                  _buildGameButton(translate('Bill value conversion'), () {
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
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
} 