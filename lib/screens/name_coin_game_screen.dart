import 'package:flutter/material.dart';
import '../globals/score.dart';
import '../widgets/score_widget.dart';

class NameCoinGameScreen extends StatefulWidget {
  const NameCoinGameScreen({super.key});

  @override
  State<NameCoinGameScreen> createState() => _NameCoinGameScreenState();
}

class _NameCoinGameScreenState extends State<NameCoinGameScreen> {
  static bool hasAwardedGlobalScore = false;
  bool isSpanish = false;
  int currentQuestion = 1;
  bool showFeedback = false;
  String? selectedAnswer;
  bool? isCorrect;
  String feedback = '';
  List<bool> answeredCorrectly = [false, false, false, false];
  bool scoreAwarded = false;

  final Map<String, String> translations = {
    'Name the Coin': 'Nombra la Moneda',
    'Question': 'Pregunta',
    'Choose the correct answer': 'Elige la respuesta correcta',
    'Correct!': '¡Correcto!',
    'Try again!': '¡Inténtalo de nuevo!',
    'Next': 'Siguiente',
    'Prev': 'Anterior',
    'Penny': 'Centavo',
    'Nickel': 'Níquel',
    'Dime': 'Diez Centavos',
    'Quarter': 'Cuarto de Dólar',
    'Fun fact: The dime is the smallest and thinnest of all U.S. coins!': 
    '¡Dato curioso: La moneda de diez centavos es la más pequeña y delgada de todas las monedas estadounidenses!',
    'Fun fact: The Lincoln penny design is the longest-running design in U.S. Mint history!':
    '¡Dato curioso: El diseño del centavo Lincoln es el diseño más antiguo en la historia de la Casa de Moneda de EE. UU.!',
    'Fun fact: Despite its name, the nickel is actually made of 75% copper!':
    '¡Dato curioso: A pesar de su nombre, el níquel está hecho de 75% cobre!',
    'Fun fact: State quarters program was one of the most successful coin programs in history!':
    '¡Dato curioso: El programa de cuartos estatales fue uno de los programas de monedas más exitosos de la historia!',
  };

  String translate(String text) {
    if (!isSpanish) return text;
    return translations[text] ?? text;
  }

  final List<Map<String, dynamic>> questions = [
    {
      'image': 'assets/cent_front.png',
      'options': ['Penny', 'Nickel', 'Dime', 'Quarter'],
      'correct': 'Penny',
      'fact': 'Fun fact: The Lincoln penny design is the longest-running design in U.S. Mint history!'
    },
    {
      'image': 'assets/nickel_front.png',
      'options': ['Penny', 'Nickel', 'Dime', 'Quarter'],
      'correct': 'Nickel',
      'fact': 'Fun fact: Despite its name, the nickel is actually made of 75% copper!'
    },
    {
      'image': 'assets/dime_front.png',
      'options': ['Penny', 'Nickel', 'Dime', 'Quarter'],
      'correct': 'Dime',
      'fact': 'Fun fact: The dime is the smallest and thinnest of all U.S. coins!'
    },
    {
      'image': 'assets/quarter_front.png',
      'options': ['Penny', 'Nickel', 'Dime', 'Quarter'],
      'correct': 'Quarter',
      'fact': 'Fun fact: State quarters program was one of the most successful coin programs in history!'
    },
  ];

  void checkAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      showFeedback = true;
      isCorrect = answer == questions[currentQuestion - 1]['correct'];
      
      if (isCorrect!) {
        answeredCorrectly[currentQuestion - 1] = true;
        feedback = '${translate('Correct!')}\n${translate(questions[currentQuestion - 1]['fact'])}';
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
                    translate('Name the Coin'),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB54B3C),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${translate('Question')} $currentQuestion',
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
                    questions[currentQuestion - 1]['image'],
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 40),
                  ...questions[currentQuestion - 1]['options'].map<Widget>((option) {
                    final bool isSelected = selectedAnswer == option;
                    final bool isCorrectAnswer = option == questions[currentQuestion - 1]['correct'];
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed: showFeedback ? null : () => checkAnswer(option),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: showFeedback
                              ? (isCorrectAnswer ? Colors.green.shade100 : (isSelected ? Colors.red.shade100 : Colors.grey.shade100))
                              : (isSelected ? Colors.blue.shade100 : Colors.grey.shade100),
                          minimumSize: const Size(200, 50),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              translate(option),
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            if (showFeedback && isCorrectAnswer)
                              const Icon(Icons.check, color: Colors.green)
                            else if (showFeedback && isSelected && !isCorrectAnswer)
                              const Icon(Icons.close, color: Colors.red),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
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
                            selectedAnswer = null;
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
                            selectedAnswer = null;
                          });
                        }),
                    ],
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
                const ScoreWidget(),
                const SizedBox(height: 8),
                IconButton(
                  icon: const Icon(
                    Icons.refresh,
                    size: 28,
                    color: Colors.blue,
                  ),
                  tooltip: 'Reset Score',
                  onPressed: () {
                    GlobalScore.resetScore();
                  },
                ),
              ],
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
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        minimumSize: const Size(100, 40),
      ),
      child: Text(translate(text)),
    );
  }
} 