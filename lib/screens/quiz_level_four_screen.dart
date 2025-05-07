import 'package:flutter/material.dart';
import 'dart:math';
import '../globals/score.dart';

class QuizLevelFourScreen extends StatefulWidget {
  const QuizLevelFourScreen({super.key});

  @override
  State<QuizLevelFourScreen> createState() => _QuizLevelFourScreenState();
}

class _QuizLevelFourScreenState extends State<QuizLevelFourScreen> {
  static bool hasAwardedGlobalScore = false;
  int currentQuestionIndex = 0;
  int score = 0;
  bool showResult = false;
  List<String> userAnswers = [];
  bool scoreAwarded = false;
  
  Map<String, String> translations = {
    'Money Problems': 'Problemas de Dinero',
    'Submit': 'Enviar',
    'Next': 'Siguiente',
    'Try Again': 'Intenta de Nuevo',
    'Correct!': '¡Correcto!',
    'Incorrect': 'Incorrecto',
    'Your Score': 'Tu Puntaje',
    'Back to Quiz': 'Volver al Quiz',
  };

  bool isSpanish = false;

  final List<Map<String, dynamic>> problems = [
    {
      'question': {
        'en': 'If you buy a toy for \$4.25 and pay with a \$5 bill, how much change should you receive?',
        'es': 'Si compras un juguete por \$4.25 y pagas con un billete de \$5, ¿cuánto cambio deberías recibir?'
      },
      'image': 'assets/five_front.png',
      'answer': '0.75',
      'options': ['0.75', '1.25', '0.85', '1.75'],
    },
    {
      'question': {
        'en': 'You have 3 quarters, 2 dimes, and 1 nickel. How much money do you have in total?',
        'es': 'Tienes 3 monedas de 25¢, 2 de 10¢ y 1 de 5¢. ¿Cuánto dinero tienes en total?'
      },
      'image': 'assets/quarter_front.png',
      'answer': '1.00',
      'options': ['0.85', '1.00', '1.15', '0.95'],
    },
    {
      'question': {
        'en': 'If a sandwich costs \$6.50 and you pay with a \$10 bill, how much change will you get?',
        'es': 'Si un sándwich cuesta \$6.50 y pagas con un billete de \$10, ¿cuánto cambio recibirás?'
      },
      'image': 'assets/ten_front.png',
      'answer': '3.50',
      'options': ['3.50', '4.50', '2.50', '3.75'],
    },
    {
      'question': {
        'en': 'You need to pay \$1.85. You have 1 dollar bill and 4 quarters. Do you have enough? If yes, how much extra?',
        'es': 'Necesitas pagar \$1.85. Tienes 1 billete de \$1 y 4 monedas de 25¢. ¿Tienes suficiente? Si es así, ¿cuánto extra?'
      },
      'image': 'assets/one_front.png',
      'answer': '0.15',
      'options': ['0.15', '0.25', '0.35', 'Not enough'],
    },
  ];

  String translate(String text) {
    if (!isSpanish) return text;
    return translations[text] ?? text;
  }

  String getQuestion() {
    return problems[currentQuestionIndex]['question'][isSpanish ? 'es' : 'en'];
  }

  void checkAnswer(String selected) {
    setState(() {
      if (selected == problems[currentQuestionIndex]['answer']) {
        score += 10;
      }
      userAnswers.add(selected);
      
      if (currentQuestionIndex < problems.length - 1) {
        currentQuestionIndex++;
      } else {
        showResult = true;
        if (score == problems.length * 10 && !scoreAwarded && !hasAwardedGlobalScore) {
          GlobalScore.addPoints(0.5);
          scoreAwarded = true;
          hasAwardedGlobalScore = true;
        }
      }
    });
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      showResult = false;
      userAnswers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('Money Problems')),
        actions: [
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () {
              setState(() {
                isSpanish = !isSpanish;
              });
            },
          ),
        ],
      ),
      body: showResult ? _buildResultScreen() : _buildQuestionScreen(),
    );
  }

  Widget _buildQuestionScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Score: $score',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    getQuestion(),
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    problems[currentQuestionIndex]['image'],
                    height: 100,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 100);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...problems[currentQuestionIndex]['options'].map<Widget>((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: () => checkAnswer(option),
                child: Text('\$$option'),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildResultScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            translate('Your Score'),
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          Text(
            '$score/${problems.length * 10}',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: resetQuiz,
            child: Text(translate('Try Again')),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(translate('Back to Quiz')),
          ),
        ],
      ),
    );
  }
} 