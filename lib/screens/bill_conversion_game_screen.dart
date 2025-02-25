import 'package:flutter/material.dart';

class BillConversionGameScreen extends StatefulWidget {
  const BillConversionGameScreen({super.key});

  @override
  State<BillConversionGameScreen> createState() => _BillConversionGameScreenState();
}

class _BillConversionGameScreenState extends State<BillConversionGameScreen> {
  int currentQuestion = 1;
  bool showFeedback = false;
  bool? isCorrect;
  String feedback = '';

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'How many five dollar bills equal one twenty dollar bill?',
      'correctAnswer': '4 five dollar bills',
      'options': [
        '3 five dollar bills',
        '4 five dollar bills',
        '5 five dollar bills',
        '6 five dollar bills'
      ],
      'fact': 'Fun fact: \$20 = \$5 × 4, this is a common combination in ATMs!'
    },
    {
      'question': 'How many ten dollar bills equal one hundred dollar bill?',
      'correctAnswer': '10 ten dollar bills',
      'options': [
        '8 ten dollar bills',
        '9 ten dollar bills',
        '10 ten dollar bills',
        '11 ten dollar bills'
      ],
      'fact': 'Fun fact: \$100 = \$10 × 10, making it easy to calculate percentages!'
    },
    {
      'question': 'How many twenty dollar bills equal one hundred dollar bill?',
      'correctAnswer': '5 twenty dollar bills',
      'options': [
        '4 twenty dollar bills',
        '5 twenty dollar bills',
        '6 twenty dollar bills',
        '7 twenty dollar bills'
      ],
      'fact': 'Fun fact: Both \$20 and \$100 bills are commonly used in ATMs!'
    },
    {
      'question': 'How many one dollar bills equal one ten dollar bill?',
      'correctAnswer': '10 one dollar bills',
      'options': [
        '8 one dollar bills',
        '9 one dollar bills',
        '10 one dollar bills',
        '11 one dollar bills'
      ],
      'fact': 'Fun fact: The \$1 bill is the most widely circulated denomination!'
    },
    {
      'question': 'How many two dollar bills equal one twenty dollar bill?',
      'correctAnswer': '10 two dollar bills',
      'options': [
        '8 two dollar bills',
        '9 two dollar bills',
        '10 two dollar bills',
        '11 two dollar bills'
      ],
      'fact': 'Fun fact: The \$2 bill is still printed but in much smaller quantities!'
    },
    {
      'question': 'How many five dollar bills equal one fifty dollar bill?',
      'correctAnswer': '10 five dollar bills',
      'options': [
        '8 five dollar bills',
        '9 five dollar bills',
        '10 five dollar bills',
        '11 five dollar bills'
      ],
      'fact': 'Fun fact: The \$50 bill features Ulysses S. Grant!'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentQ = questions[currentQuestion - 1];

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Bill value conversion',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB54B3C),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Question $currentQuestion',
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  currentQ['question'],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Column(
                children: currentQ['options'].map<Widget>((option) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: _buildAnswerButton(
                      option,
                      option == currentQ['correctAnswer'],
                      currentQ['fact'],
                    ),
                  );
                }).toList(),
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
        text,
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
        onPressed: () {
          setState(() {
            showFeedback = true;
            isCorrect = isCorrectAnswer;
            if (isCorrectAnswer) {
              feedback = 'Correct!\n$fact';
            } else {
              feedback = 'Try again!';
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
          text,
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