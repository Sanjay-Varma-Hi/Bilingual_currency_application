import 'package:flutter/material.dart';
import '../globals/score.dart';

class NameBillGameScreen extends StatefulWidget {
  const NameBillGameScreen({super.key});

  @override
  State<NameBillGameScreen> createState() => _NameBillGameScreenState();
}

class _NameBillGameScreenState extends State<NameBillGameScreen> {
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
      'image': 'assets/one_front.png',
      'correctAnswer': 'One Dollar',
      'options': ['One Dollar', 'Two Dollars'],
      'fact': 'Fun fact: The \$1 bill features George Washington and makes up about 45% of all US currency printing!'
    },
    {
      'image': 'assets/two_front.png',
      'correctAnswer': 'Two Dollars',
      'options': ['One Dollar', 'Two Dollars'],
      'fact': 'Fun fact: The \$2 bill features Thomas Jefferson and the signing of the Declaration of Independence!'
    },
    {
      'image': 'assets/five_front.png',
      'correctAnswer': 'Five Dollars',
      'options': ['Five Dollars', 'Ten Dollars'],
      'fact': 'Fun fact: The \$5 bill features Abraham Lincoln and the Lincoln Memorial!'
    },
    {
      'image': 'assets/ten_front.png',
      'correctAnswer': 'Ten Dollars',
      'options': ['Five Dollars', 'Ten Dollars'],
      'fact': 'Fun fact: The \$10 bill features Alexander Hamilton, the first Secretary of the Treasury!'
    },
    {
      'image': 'assets/twenty_front.png',
      'correctAnswer': 'Twenty Dollars',
      'options': ['Twenty Dollars', 'Fifty Dollars'],
      'fact': 'Fun fact: The \$20 bill features Andrew Jackson and the White House!'
    },
    {
      'image': 'assets/hundred_front.png',
      'correctAnswer': 'Hundred Dollars',
      'options': ['Fifty Dollars', 'Hundred Dollars'],
      'fact': 'Fun fact: The \$100 bill features Benjamin Franklin and Independence Hall!'
    },
  ];

  final Map<String, String> translations = {
    'Name the Bill': 'Nombra el Billete',
    'Question': 'Pregunta',
    'Choose the correct answer': 'Elige la respuesta correcta',
    'Correct!': '¡Correcto!',
    'Try again!': '¡Inténtalo de nuevo!',
    'Next': 'Siguiente',
    'Prev': 'Anterior',
    'One Dollar': 'Un Dólar',
    'Two Dollars': 'Dos Dólares',
    'Five Dollars': 'Cinco Dólares',
    'Ten Dollars': 'Diez Dólares',
    'Twenty Dollars': 'Veinte Dólares',
    'Fifty Dollars': 'Cincuenta Dólares',
    'Hundred Dollars': 'Cien Dólares',
    'Fun fact: The \$1 bill features George Washington and makes up about 45% of all US currency printing!':
    '¡Dato curioso: El billete de \$1 presenta a George Washington y constituye aproximadamente el 45% de toda la impresión de moneda estadounidense!',
    // Add other fun fact translations
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
                    translate('Name the Bill'),
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
                    translate('Choose the correct answer'),
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
                        Icons.attach_money,
                        size: 150,
                        color: Colors.grey,
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAnswerButton(
                        currentQ['options'][0],
                        currentQ['options'][0] == currentQ['correctAnswer'],
                        currentQ['fact'],
                      ),
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
      width: 140,
      child: ElevatedButton(
        onPressed: () {
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
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE6C5B9),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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