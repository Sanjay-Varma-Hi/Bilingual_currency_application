import 'package:flutter/material.dart';

class ValueBillGameScreen extends StatefulWidget {
  const ValueBillGameScreen({super.key});

  @override
  State<ValueBillGameScreen> createState() => _ValueBillGameScreenState();
}

class _ValueBillGameScreenState extends State<ValueBillGameScreen> {
  int currentQuestion = 1;
  bool showFeedback = false;
  bool? isCorrect;
  String feedback = '';

  final List<Map<String, dynamic>> questions = [
    {
      'image': 'assets/one_front.png',
      'correctAnswer': '\$1.00 / 100 cents',
      'options': ['\$1.00 / 100 cents', '\$2.00 / 200 cents'],
      'fact': 'Fun fact: A one dollar bill lasts about 22 months in circulation!'
    },
    {
      'image': 'assets/two_front.png',
      'correctAnswer': '\$2.00 / 200 cents',
      'options': ['\$1.00 / 100 cents', '\$2.00 / 200 cents'],
      'fact': 'Fun fact: The \$2 bill was first printed in 1862!'
    },
    {
      'image': 'assets/five_front.png',
      'correctAnswer': '\$5.00 / 500 cents',
      'options': ['\$5.00 / 500 cents', '\$10.00 / 1000 cents'],
      'fact': 'Fun fact: The current \$5 bill design was introduced in 2006!'
    },
    {
      'image': 'assets/ten_front.png',
      'correctAnswer': '\$10.00 / 1000 cents',
      'options': ['\$5.00 / 500 cents', '\$10.00 / 1000 cents'],
      'fact': 'Fun fact: The \$10 bill has color-shifting ink that changes from copper to green!'
    },
    {
      'image': 'assets/twenty_front.png',
      'correctAnswer': '\$20.00 / 2000 cents',
      'options': ['\$20.00 / 2000 cents', '\$50.00 / 5000 cents'],
      'fact': 'Fun fact: The \$20 bill is the most counterfeited bill in the U.S.!'
    },
    {
      'image': 'assets/hundred_front.png',
      'correctAnswer': '\$100.00 / 10000 cents',
      'options': ['\$50.00 / 5000 cents', '\$100.00 / 10000 cents'],
      'fact': 'Fun fact: The \$100 bill has a blue security ribbon woven into the paper!'
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
                'Value of the Bill',
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
              const SizedBox(height: 10),
              const Text(
                'What is the value of this bill?',
                style: TextStyle(
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