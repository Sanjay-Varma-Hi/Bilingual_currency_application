import 'package:flutter/material.dart';
import '../globals/score.dart';

class ValueCoinGameScreen extends StatefulWidget {
  const ValueCoinGameScreen({super.key});

  @override
  State<ValueCoinGameScreen> createState() => _ValueCoinGameScreenState();
}

class _ValueCoinGameScreenState extends State<ValueCoinGameScreen> {
  static bool hasAwardedGlobalScore = false;
  int currentQuestion = 1;
  bool showFeedback = false;
  bool? isCorrect;
  String feedback = '';
  bool isSpanish = false;
  List<bool> answeredCorrectly = [false, false, false, false, false, false];
  bool scoreAwarded = false;

  final List<Map<String, dynamic>> questions = [
    {
      'image': 'assets/cent_front.png',
      'correctAnswer': '0.01\$ / 1 cent',
      'options': ['0.01\$ / 1 cent', '0.05\$ / 5 cents'],
      'fact': 'Fun fact: It costs more than 1 cent to produce a penny!'
    },
    {
      'image': 'assets/nickel_front.png',
      'correctAnswer': '0.05\$ / 5 cents',
      'options': ['0.01\$ / 1 cent', '0.05\$ / 5 cents'],
      'fact': 'Fun fact: A nickel weighs exactly 5 grams!'
    },
    {
      'image': 'assets/dime_front.png',
      'correctAnswer': '0.10\$ / 10 cents',
      'options': ['0.10\$ / 10 cents', '0.25\$ / 25 cents'],
      'fact': 'Fun fact: A dime has 118 ridges around its edge!'
    },
    {
      'image': 'assets/quarter_front.png',
      'correctAnswer': '0.25\$ / 25 cents',
      'options': ['0.10\$ / 10 cents', '0.25\$ / 25 cents'],
      'fact': 'Fun fact: A quarter has 119 ridges around its edge!'
    },
    {
      'image': 'assets/halfdollar_front.png',
      'correctAnswer': '0.50\$ / 50 cents',
      'options': ['0.50\$ / 50 cents', '1.00\$ / 100 cents'],
      'fact': 'Fun fact: The Half Dollar was first minted in 1794!'
    },
    {
      'image': 'assets/dollar_front.png',
      'correctAnswer': '1.00\$ / 100 cents',
      'options': ['0.50\$ / 50 cents', '1.00\$ / 100 cents'],
      'fact': 'Fun fact: The Dollar coin has a smooth edge with inscriptions!'
    },
  ];

  final Map<String, String> translations = {
    'Value of the Coin': 'Valor de la Moneda',
    'Question': 'Pregunta',
    'What is the value of this coin?': '¿Cuál es el valor de esta moneda?',
    'Correct!': '¡Correcto!',
    'Try again!': '¡Inténtalo de nuevo!',
    'Next': 'Siguiente',
    'Prev': 'Anterior',
    '0.01\$ / 1 cent': '0.01\$ / 1 centavo',
    '0.05\$ / 5 cents': '0.05\$ / 5 centavos',
    '0.10\$ / 10 cents': '0.10\$ / 10 centavos',
    '0.25\$ / 25 cents': '0.25\$ / 25 centavos',
    '0.50\$ / 50 cents': '0.50\$ / 50 centavos',
    '1.00\$ / 100 cents': '1.00\$ / 100 centavos',
    // Add translations for fun facts
  };

  String translate(String text) {
    if (!isSpanish) return text;
    return translations[text] ?? text;
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = questions[currentQuestion - 1];

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
                    translate('Value of the Coin'),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB54B3C),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    translate('Question') + ' $currentQuestion',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    translate('What is the value of this coin?'),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Image.asset(
                    currentQ['image'],
                    height: 150,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.grey,
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      _buildAnswerButton(
                        currentQ['options'][0],
                        currentQ['options'][0] == currentQ['correctAnswer'],
                        currentQ['fact'],
                      ),
                      const SizedBox(height: 20),
                      _buildAnswerButton(
                        currentQ['options'][1],
                        currentQ['options'][1] == currentQ['correctAnswer'],
                        currentQ['fact'],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (showFeedback)
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: isCorrect! ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        feedback,
                        style: TextStyle(
                          fontSize: 16,
                          color: isCorrect! ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (currentQuestion > 1)
                        _buildNavButton('Prev', () {
                          setState(() {
                            currentQuestion--;
                            showFeedback = false;
                          });
                        }),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(
                          Icons.home,
                          size: 40,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 20),
                      if (currentQuestion < questions.length)
                        _buildNavButton('Next', () {
                          setState(() {
                            currentQuestion++;
                            showFeedback = false;
                          });
                        }),
                    ],
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
                setState(() {
                  isSpanish = !isSpanish;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[100],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        translate(text),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAnswerButton(String text, bool isCorrectAnswer, String fact) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: showFeedback ? null : () {
          setState(() {
            showFeedback = true;
            isCorrect = isCorrectAnswer;
            if (isCorrectAnswer) {
              answeredCorrectly[currentQuestion - 1] = true;
              feedback = translate('Correct!') + '\n' + translate(fact);
            } else {
              answeredCorrectly[currentQuestion - 1] = false;
              feedback = translate('Try again!');
            }

            // If last question and all correct, award score (only once per session)
            if (currentQuestion == questions.length &&
                answeredCorrectly.every((v) => v) &&
                !scoreAwarded &&
                !hasAwardedGlobalScore) {
              GlobalScore.addPoints(0.5);
              scoreAwarded = true;
              hasAwardedGlobalScore = true;
              GlobalScore.updateQuizScore('Value of the Coin', 1);
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE6C5B9),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          translate(text),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
} 