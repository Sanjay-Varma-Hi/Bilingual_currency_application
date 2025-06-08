import 'package:flutter/material.dart';
import '../widgets/score_with_popup_widget.dart';
import '../globals/score.dart';
import 'quiz_level_three_screen.dart';

class QuizLevelTwoScreen extends StatefulWidget {
  const QuizLevelTwoScreen({super.key});

  @override
  State<QuizLevelTwoScreen> createState() => _QuizLevelTwoScreenState();
}

class _QuizLevelTwoScreenState extends State<QuizLevelTwoScreen> {
  static bool hasAwardedGlobalScore = false;
  bool isSpanish = false;
  int currentQuestionIndex = 0;
  int score = 0;
  Map<int, String?> userAnswers = {};
  bool showResults = false;
  Map<int, bool> answerCorrectness = {};
  bool scoreAwarded = false;

  final Map<String, String> translations = {
    'Level 2': 'Nivel 2',
    'MCQs': 'Preguntas de opción múltiple',
    'Score': 'Puntaje',
    'Next': 'Siguiente',
    'Previous': 'Anterior',
    'Submit': 'Enviar',
    'Congratulations!': '¡Felicitaciones!',
    'You completed the level!': '¡Completaste el nivel!',
    'Your score': 'Tu puntaje',
    'Try Again': 'Intentar de nuevo',
    'Next Level': 'Siguiente Nivel',
    'How many pennies make a nickel?': '¿Cuántos centavos hacen un níquel?',
    'How many nickels make a quarter?': '¿Cuántos níqueles hacen un cuarto?',
    'How many dimes make a dollar?': '¿Cuántos diez centavos hacen un dólar?',
    'How many quarters make a dollar?': '¿Cuántos cuartos hacen un dólar?',
    'How many pennies make a dollar?': '¿Cuántos centavos hacen un dólar?',
    '5 pennies': '5 centavos',
    '10 pennies': '10 centavos',
    '3 pennies': '3 centavos',
    '7 pennies': '7 centavos',
    '4 nickels': '4 níqueles',
    '5 nickels': '5 níqueles',
    '3 nickels': '3 níqueles',
    '6 nickels': '6 níqueles',
    '8 dimes': '8 diez centavos',
    '10 dimes': '10 diez centavos',
    '12 dimes': '12 diez centavos',
    '15 dimes': '15 diez centavos',
    '3 quarters': '3 cuartos',
    '4 quarters': '4 cuartos',
    '5 quarters': '5 cuartos',
    '6 quarters': '6 cuartos',
    '90 pennies': '90 centavos',
    '100 pennies': '100 centavos',
    '80 pennies': '80 centavos',
    '110 pennies': '110 centavos',
  };

  final List<QuizQuestion> questions = [
    QuizQuestion(
      question: 'How many pennies make a nickel?',
      options: ['5 pennies', '10 pennies', '3 pennies', '7 pennies'],
      correctAnswer: '5 pennies',
    ),
    QuizQuestion(
      question: 'How many nickels make a quarter?',
      options: ['4 nickels', '5 nickels', '3 nickels', '6 nickels'],
      correctAnswer: '5 nickels',
    ),
    QuizQuestion(
      question: 'How many dimes make a dollar?',
      options: ['8 dimes', '10 dimes', '12 dimes', '15 dimes'],
      correctAnswer: '10 dimes',
    ),
    QuizQuestion(
      question: 'How many quarters make a dollar?',
      options: ['3 quarters', '4 quarters', '5 quarters', '6 quarters'],
      correctAnswer: '4 quarters',
    ),
    QuizQuestion(
      question: 'How many pennies make a dollar?',
      options: ['90 pennies', '100 pennies', '80 pennies', '110 pennies'],
      correctAnswer: '100 pennies',
    ),
  ];

  String translate(String text) {
    if (!isSpanish) return text;
    return translations[text] ?? text;
  }

  void checkAnswer(String selectedAnswer) {
    setState(() {
      // Only allow answering if not already answered
      if (!userAnswers.containsKey(currentQuestionIndex)) {
        userAnswers[currentQuestionIndex] = selectedAnswer;
        bool isCorrect = selectedAnswer == questions[currentQuestionIndex].correctAnswer;
        answerCorrectness[currentQuestionIndex] = isCorrect;
        if (isCorrect) {
          score += 10;
        }
      }
    });
  }

  void submitQuiz() {
    setState(() {
      showResults = true;
      // Only award 0.5 points if all answers are correct and not already awarded
      if (score == questions.length * 10 && !scoreAwarded && !hasAwardedGlobalScore) {
        GlobalScore.addPoints(0.5);
        scoreAwarded = true;
        hasAwardedGlobalScore = true;
      }
      // Update Level 2 score in the popup
      GlobalScore.updateQuizScore('Level 2', score);
    });
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      score = 0;
      userAnswers = {};
      showResults = false;
      answerCorrectness = {};
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translate('Level 2'),
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB54B3C),
                              ),
                            ),
                            Text(
                              translate('MCQs'),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Column(
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${translate('Score')}: $score',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translate(currentQuestion.question),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ...currentQuestion.options.map((option) {
                            final isSelected = userAnswers[currentQuestionIndex] == option;
                            final hasAnswered = userAnswers.containsKey(currentQuestionIndex);
                            final isCorrect = option == currentQuestion.correctAnswer;
                            
                            Color? backgroundColor;
                            Color? borderColor;
                            
                            if (hasAnswered && isSelected) {
                              if (isCorrect) {
                                backgroundColor = Colors.green.withOpacity(0.1);
                                borderColor = Colors.green;
                              } else {
                                backgroundColor = Colors.red.withOpacity(0.1);
                                borderColor = Colors.red;
                              }
                            } else if (hasAnswered && isCorrect) {
                              backgroundColor = Colors.green.withOpacity(0.1);
                              borderColor = Colors.green;
                            } else {
                              backgroundColor = isSelected
                                  ? Colors.blue.withOpacity(0.1)
                                  : Colors.grey.withOpacity(0.05);
                              borderColor = isSelected
                                  ? Colors.blue
                                  : Colors.grey.withOpacity(0.3);
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: InkWell(
                                onTap: hasAnswered ? null : () => checkAnswer(option),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: borderColor,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: borderColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: isSelected
                                            ? Center(
                                                child: Icon(
                                                  hasAnswered && !isCorrect ? Icons.close : Icons.check,
                                                  size: 16,
                                                  color: borderColor,
                                                ),
                                              )
                                            : null,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        translate(option),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: isSelected ? borderColor : Colors.black87,
                                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentQuestionIndex > 0)
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                currentQuestionIndex--;
                              });
                            },
                            icon: const Icon(Icons.arrow_back),
                            label: Text(translate('Previous')),
                          )
                        else
                          const SizedBox(width: 100),
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
                        if (currentQuestionIndex < questions.length - 1)
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                currentQuestionIndex++;
                              });
                            },
                            icon: const Icon(Icons.arrow_forward),
                            label: Text(translate('Next')),
                          )
                        else
                          ElevatedButton.icon(
                            onPressed: submitQuiz,
                            icon: const Icon(Icons.check),
                            label: Text(translate('Submit')),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (showResults)
                _buildResultsOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsOverlay() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                translate('Congratulations!'),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB54B3C),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${translate('Your score')}: $score',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      resetQuiz();
                    },
                    child: Text(translate('Try Again')),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizLevelThreeScreen(),
                        ),
                      );
                    },
                    child: Text(translate('Next Level')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final String correctAnswer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
} 