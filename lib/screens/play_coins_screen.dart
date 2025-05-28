import 'package:flutter/material.dart';
import '../widgets/score_with_popup_widget.dart';
import 'name_coin_game_screen.dart';
import 'value_coin_game_screen.dart';
import 'conversion_game_screen.dart';

class PlayCoinsScreen extends StatefulWidget {
  const PlayCoinsScreen({super.key});

  @override
  State<PlayCoinsScreen> createState() => _PlayCoinsScreenState();
}

class _PlayCoinsScreenState extends State<PlayCoinsScreen> {
  bool isSpanish = false;

  final Map<String, String> translations = {
    'Coin Games': 'Juegos de Monedas',
    'Name the Coin': 'Nombra la Moneda',
    'Value of the Coin': 'Valor de la Moneda',
    'Coin value conversion': 'Conversión de valor de monedas',
  };

  String translate(String text) {
    if (!isSpanish) return text;
    return translations[text] ?? text;
  }

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
                  const SizedBox(height: 40),
                  Text(
                    translate('Coin Games'),
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
                      _buildGameButton(translate('Name the Coin'), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NameCoinGameScreen()),
                        );
                      }),
                      const SizedBox(height: 20),
                      _buildGameButton(translate('Value of the Coin'), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ValueCoinGameScreen()),
                        );
                      }),
                      const SizedBox(height: 20),
                      _buildGameButton(translate('Coin value conversion'), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ConversionGameScreen()),
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
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.translate,
                    size: 30,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    setState(() {
                      isSpanish = !isSpanish;
                    });
                  },
                ),
                const SizedBox(height: 8),
                const ScoreWithPopupWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 200,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightGreen[100],
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