import 'package:flutter/material.dart';

class NameBillGameScreen extends StatefulWidget {
  const NameBillGameScreen({super.key});

  @override
  State<NameBillGameScreen> createState() => _NameBillGameScreenState();
}

class _NameBillGameScreenState extends State<NameBillGameScreen> {
  int currentQuestion = 1;
  bool showFeedback = false;
  bool? isCorrect;
  String feedback = '';

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
                'Name the Bill',
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
                'Choose the correct answer',
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
      width: 140,
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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