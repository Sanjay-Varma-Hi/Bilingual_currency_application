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
  };

  final List<QuizQuestion> questions = [
    QuizQuestion(
      question: 'How many apples can you buy with a \$10 bill if each apple costs \$1?',
      options: ['5 Apples', '10 Apples', '15 Apples', '2 Apples'],
      correctAnswer: '10 Apples',
    ),
    QuizQuestion(
      question: 'If you have \$20 and each toy costs \$4, how many toys can you buy?',
      options: ['2 Toys', '4 Toys', '5 Toys', '6 Toys'],
      correctAnswer: '5 Toys',
    ),
    QuizQuestion(
      question: 'Sally has a \$50 bill. She wants to buy books that cost \$7 each. How many books can she buy?',
      options: ['6 Books', '7 Books', '8 Books', '9 Books'],
      correctAnswer: '7 Books',
    ),
    QuizQuestion(
      question: 'John has \$15. If he buys 2 candies that cost \$2 each, how much money will he have left?',
      options: ['10', '11', '12', '13'],
      correctAnswer: '11',
    ),
    QuizQuestion(
      question: 'A pencil costs \$3. How many pencils can you buy with \$18?',
      options: ['4 Pencils', '5 Pencils', '6 Pencils', '7 Pencils'],
      correctAnswer: '6 Pencils',
    ),
    QuizQuestion(
      question: 'If a scoop of ice cream costs \$2, how many scoops can you buy with a \$10 bill?',
      options: ['3 Scoops', '4 Scoops', '5 Scoops', '6 Scoops'],
      correctAnswer: '5 Scoops',
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
                            currentQuestion.question,
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
                                        option,
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