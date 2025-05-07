import 'package:flutter/material.dart';
import '../globals/score.dart';

class ConversionGameScreen extends StatefulWidget {
  const ConversionGameScreen({super.key});

  @override
  State<ConversionGameScreen> createState() => _ConversionGameScreenState();
}

class _ConversionGameScreenState extends State<ConversionGameScreen> {
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
      'question': 'Equivalent value of half dollar in quarters is',
      'correctAnswer': '2 quarters',
      'options': ['1 quarter', '2 quarters', '3 quarters', '4 quarters'],
      'fact': 'Fun fact: A half dollar equals 50 cents, which is the same as two quarters (25¢ × 2)!'
    },
    {
      'question': 'Equivalent value of dollar in quarters is',
      'correctAnswer': '4 quarters',
      'options': ['2 quarters', '3 quarters', '4 quarters', '5 quarters'],
      'fact': 'Fun fact: A dollar equals 100 cents, which can be made with four quarters (25¢ × 4)!'
    },
    {
      'question': 'Equivalent value of quarter in nickels is',
      'correctAnswer': '5 nickels',
      'options': ['3 nickels', '4 nickels', '5 nickels', '6 nickels'],
      'fact': 'Fun fact: A quarter equals 25 cents, which is the same as five nickels (5¢ × 5)!'
    },
    {
      'question': 'Equivalent value of dime in pennies is',
      'correctAnswer': '10 pennies',
      'options': ['5 pennies', '10 pennies', '15 pennies', '20 pennies'],
      'fact': 'Fun fact: A dime equals 10 cents, which is the same as ten pennies (1¢ × 10)!'
    },
    {
      'question': 'Equivalent value of quarter in dimes is',
      'correctAnswer': '2 dimes and 1 nickel',
      'options': ['2 dimes', '2 dimes and 1 nickel', '3 dimes', '1 dime and 3 nickels'],
      'fact': 'Fun fact: A quarter (25¢) can be made with two dimes (20¢) plus one nickel (5¢)!'
    },
    {
      'question': 'Equivalent value of dollar in dimes is',
      'correctAnswer': '10 dimes',
      'options': ['8 dimes', '9 dimes', '10 dimes', '11 dimes'],
      'fact': 'Fun fact: A dollar equals 100 cents, which is the same as ten dimes (10¢ × 10)!'
    },
  ];

  final Map<String, String> translations = {
    'Coin value conversion': 'Conversión de valor de monedas',
    'Question': 'Pregunta',
    'Correct!': '¡Correcto!',
    'Try again!': '¡Inténtalo de nuevo!',
    'Next': 'Siguiente',
    'Prev': 'Anterior',
    'Equivalent value of half dollar in quarters is': 'El valor equivalente de medio dólar en cuartos es',
    'Equivalent value of dollar in quarters is': 'El valor equivalente de un dólar en cuartos es',
    '2 quarters': '2 cuartos',
    '4 quarters': '4 cuartos',
    '5 nickels': '5 níqueles',
    '10 pennies': '10 centavos',
    '2 dimes and 1 nickel': '2 monedas de diez centavos y 1 níquel',
    '10 dimes': '10 monedas de diez centavos',
    'How many five dollar bills equal one twenty dollar bill?': 
    '¿Cuántos billetes de cinco dólares equivalen a un billete de veinte dólares?',
    'How many ten dollar bills equal one hundred dollar bill?':
    '¿Cuántos billetes de diez dólares equivalen a un billete de cien dólares?',
    'How many twenty dollar bills equal one hundred dollar bill?':
    '¿Cuántos billetes de veinte dólares equivalen a un billete de cien dólares?',
    'How many one dollar bills equal one ten dollar bill?':
    '¿Cuántos billetes de un dólar equivalen a un billete de diez dólares?',
    'How many two dollar bills equal one twenty dollar bill?':
    '¿Cuántos billetes de dos dólares equivalen a un billete de veinte dólares?',
    'How many five dollar bills equal one fifty dollar bill?':
    '¿Cuántos billetes de cinco dólares equivalen a un billete de cincuenta dólares?',
    '4 five dollar bills': '4 billetes de cinco dólares',
    '10 ten dollar bills': '10 billetes de diez dólares',
    '5 twenty dollar bills': '5 billetes de veinte dólares',
    '10 one dollar bills': '10 billetes de un dólar',
    '10 two dollar bills': '10 billetes de dos dólares',
    '10 five dollar bills': '10 billetes de cinco dólares',
    'Fun fact: \$20 = \$5 × 4, this is a common combination in ATMs!':
    '¡Dato curioso: \$20 = \$5 × 4, esta es una combinación común en los cajeros automáticos!',
    'Fun fact: \$100 = \$10 × 10, making it easy to calculate percentages!':
    '¡Dato curioso: \$100 = \$10 × 10, ¡lo que facilita el cálculo de porcentajes!',
    'Fun fact: Both \$20 and \$100 bills are commonly used in ATMs!':
    '¡Dato curioso: Los billetes de \$20 y \$100 son comúnmente usados en los cajeros automáticos!',
    'Fun fact: The \$1 bill is the most widely circulated denomination!':
    '¡Dato curioso: ¡El billete de \$1 es la denominación más circulada!',
    'Fun fact: The \$2 bill is still printed but in much smaller quantities!':
    '¡Dato curioso: ¡El billete de \$2 todavía se imprime pero en cantidades mucho menores!',
    'Fun fact: The \$50 bill features Ulysses S. Grant!':
    '¡Dato curioso: ¡El billete de \$50 presenta a Ulysses S. Grant!',
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
                    translate('Coin value conversion'),
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
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      translate(currentQ['question']),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Four answer buttons in vertical column
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
                  const SizedBox(height: 30),
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