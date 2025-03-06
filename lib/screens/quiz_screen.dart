import 'package:flutter/material.dart';
import 'quiz_level_one_screen.dart';
import 'quiz_level_two_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool isSpanish = false;

  final Map<String, String> translations = {
    'Quiz Levels': 'Niveles de Prueba',
    'Level 1': 'Nivel 1',
    'Level 2': 'Nivel 2',
    'Matching Game': 'Juego de Emparejar',
    'Match coins and bills with their values': 'Emparejar monedas y billetes con sus valores',
    'MCQs': 'Preguntas de opción múltiple',
    'Practice with word problems': 'Practica con problemas escritos',
  };

  String translate(String text) {
    if (!isSpanish) return text;
    return translations[text] ?? text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(24, 20, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      translate('Quiz Levels'),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB54B3C),
                      ),
                    ),
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
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ListView(
                    children: [
                      _buildLevelCard(
                        title: translate('Level 1'),
                        subtitle: translate('Matching Game'),
                        description: translate('Match coins and bills with their values'),
                        color: Colors.lightGreen[100]!,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuizLevelOneScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildLevelCard(
                        title: translate('Level 2'),
                        subtitle: translate('MCQs'),
                        description: translate('Practice with word problems'),
                        color: Colors.blue[100]!,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuizLevelTwoScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: IconButton(
                    icon: const Icon(
                      Icons.home,
                      size: 40,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard({
    required String title,
    required String subtitle,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB54B3C),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 