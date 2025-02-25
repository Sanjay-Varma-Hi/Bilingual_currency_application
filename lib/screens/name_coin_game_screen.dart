import 'package:flutter/material.dart';

class NameCoinGameScreen extends StatefulWidget {
  const NameCoinGameScreen({super.key});

  @override
  State<NameCoinGameScreen> createState() => _NameCoinGameScreenState();
}

class _NameCoinGameScreenState extends State<NameCoinGameScreen> {
  int currentQuestion = 1;
  bool showFeedback = false;
  bool? isCorrect;
  String feedback = '';
  bool isSpanish = false;
  
  final Map<String, String> translations = {
    'Name the Coin': 'Nombra la Moneda',
    'Question': 'Pregunta',
    'Choose the correct answer': 'Elige la respuesta correcta',
    'Correct!': '¡Correcto!',
    'Try again!': '¡Inténtalo de nuevo!',
    'Cent': 'Centavo',
    'Nickel': 'Níquel',
    'Dime': 'Diez Centavos',
    'Quarter': 'Cuarto de Dólar',
    'Half Dollar': 'Medio Dólar',
    'Dollar': 'Dólar',
    'Next': 'Siguiente',
    'Prev': 'Anterior',
    // Add translations for fun facts
    'Fun fact: The dime is the smallest and thinnest of all U.S. coins!': 
    '¡Dato curioso: La moneda de diez centavos es la más pequeña y delgada de todas las monedas estadounidenses!',
    // ... other fun facts translations
  };

  String translate(String text) {
    if (!isSpanish) return text;
    return translations[text] ?? text;
  }

  // List of questions with their answers and images
  final List<Map<String, dynamic>> questions = [
    {
      'image': 'assets/dime_front.png',
      'correctAnswer': 'Dime',
      'options': ['Nickel', 'Dime'],
      'fact': 'Fun fact: The dime is the smallest and thinnest of all U.S. coins!'
    },
    {
      'image': 'assets/cent_front.png',
      'correctAnswer': 'Penny',
      'options': ['Penny', 'Quarter'],
      'fact': 'Fun fact: The Lincoln penny design is the longest-running design in U.S. Mint history!'
    },
    {
      'image': 'assets/nickel_front.png',
      'correctAnswer': 'Nickel',
      'options': ['Dime', 'Nickel'],
      'fact': 'Fun fact: Despite its name, the nickel is actually made of 75% copper!'
    },
    {
      'image': 'assets/quarter_front.png',
      'correctAnswer': 'Quarter',
      'options': ['Quarter', 'Penny'],
      'fact': 'Fun fact: State quarters program was one of the most successful coin programs in history!'
    },
    {
      'image': 'assets/halfdollar_front.png',
      'correctAnswer': 'Half Dollar',
      'options': ['Half Dollar', 'Dollar'],
      'fact': 'Fun fact: The Half Dollar coin features President John F. Kennedy!'
    },
    {
      'image': 'assets/dollar_front.png',
      'correctAnswer': 'Dollar',
      'options': ['Half Dollar', 'Dollar'],
      'fact': 'Fun fact: The Dollar coin is also known as the "Golden Dollar"!'
    },
  ];

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
                  const Text(
                    'Name the Coin',
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
                  // Coin Image
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
                  // Answer Buttons
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
                  // Feedback Text
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
                  // Navigation Buttons
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
                // Translation logic will be added later
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
    return ElevatedButton(
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
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
} 