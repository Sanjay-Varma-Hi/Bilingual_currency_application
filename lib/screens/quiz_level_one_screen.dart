import 'package:flutter/material.dart';
import 'dart:math';
import 'quiz_level_two_screen.dart';
import '../widgets/score_with_popup_widget.dart';
import '../globals/score.dart';

class QuizLevelOneScreen extends StatefulWidget {
  const QuizLevelOneScreen({super.key});

  @override
  State<QuizLevelOneScreen> createState() => _QuizLevelOneScreenState();
}

class _QuizLevelOneScreenState extends State<QuizLevelOneScreen> {
  static bool hasAwardedGlobalScore = false;
  bool isSpanish = false;
  List<ItemPair> pairs = [];
  Set<String> completedPairs = {};
  int score = 0;
  bool showCongratulations = false;
  bool scoreAwarded = false;

  final Map<String, String> translations = {
    'Level 1': 'Nivel 1',
    'Score': 'Puntaje',
    'Congratulations!': '¡Felicitaciones!',
    'You completed the level!': '¡Completaste el nivel!',
    'Try Again': 'Intentar de nuevo',
    'Next Level': 'Siguiente Nivel',
    'Match the values': 'Emparejar los valores',
  };

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    pairs = [
      ItemPair(
        id: '1',
        image: 'assets/cent_front.png',
        value: '0.01\$ / 1 cent',
      ),
      ItemPair(
        id: '2',
        image: 'assets/nickel_front.png',
        value: '0.05\$ / 5 cents',
      ),
      ItemPair(
        id: '3',
        image: 'assets/dime_front.png',
        value: '0.10\$ / 10 cents',
      ),
      ItemPair(
        id: '4',
        image: 'assets/quarter_front.png',
        value: '0.25\$ / 25 cents',
      ),
      ItemPair(
        id: '5',
        image: 'assets/one_front.png',
        value: '1\$ / 100 cents',
      ),
      ItemPair(
        id: '6',
        image: 'assets/ten_front.png',
        value: '10\$ / 1000 cents',
      ),
      ItemPair(
        id: '7',
        image: 'assets/fifty_front.png',
        value: '50\$ / 5000 cents',
      ),
      ItemPair(
        id: '8',
        image: 'assets/hundred_front.png',
        value: '100\$ / 10000 cents',
      ),
    ];
    pairs.shuffle(Random());
    completedPairs = {};
    score = 0;
    showCongratulations = false;
  }

  String translate(String text) {
    if (!isSpanish) return text;
    return translations[text] ?? text;
  }

  void checkMatch(String sourceId, String targetId) {
    if (sourceId == targetId && !completedPairs.contains(sourceId)) {
      setState(() {
        completedPairs.add(sourceId);
        score += 10;
        
        if (completedPairs.length == pairs.length) {
          showCongratulations = true;
          if (!scoreAwarded && !hasAwardedGlobalScore) {
            GlobalScore.addPoints(0.5);
            scoreAwarded = true;
            hasAwardedGlobalScore = true;
          }
          GlobalScore.updateQuizScore('Level 1', score);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final leftItems = [...pairs];
    final rightItems = [...pairs]..shuffle(Random());

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
                        Text(
                          translate('Level 1'),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB54B3C),
                          ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        translate('Match the values'),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: leftItems.map((pair) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  child: Draggable<String>(
                                    data: pair.id,
                                    feedback: _buildDraggableItem(
                                      pair.image,
                                      isCompleted: completedPairs.contains(pair.id),
                                      isDragging: true,
                                    ),
                                    childWhenDragging: _buildDraggableItem(
                                      pair.image,
                                      isCompleted: completedPairs.contains(pair.id),
                                      isGhost: true,
                                    ),
                                    child: _buildDraggableItem(
                                      pair.image,
                                      isCompleted: completedPairs.contains(pair.id),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: rightItems.map((pair) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  child: DragTarget<String>(
                                    onWillAccept: (data) => data != null && !completedPairs.contains(data),
                                    onAccept: (data) {
                                      if (data != null) {
                                        checkMatch(data, pair.id);
                                      }
                                    },
                                    builder: (context, candidateData, rejectedData) {
                                      return Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: completedPairs.contains(pair.id)
                                              ? Colors.green.withOpacity(0.1)
                                              : candidateData.isNotEmpty
                                                  ? Colors.blue.withOpacity(0.1)
                                                  : Colors.grey.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(
                                            color: completedPairs.contains(pair.id)
                                                ? Colors.green
                                                : candidateData.isNotEmpty
                                                    ? Colors.blue
                                                    : Colors.grey.withOpacity(0.3),
                                            width: 2,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            pair.value,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                        icon: const Icon(
                          Icons.home,
                          size: 32,
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
              if (showCongratulations)
                _buildCongratulationsOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableItem(
    String image, {
    bool isCompleted = false,
    bool isDragging = false,
    bool isGhost = false,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: isCompleted
            ? Colors.green.withOpacity(0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isCompleted
              ? Colors.green
              : Colors.grey.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Opacity(
        opacity: isGhost ? 0.5 : 1.0,
        child: Center(
          child: Image.asset(
            image,
            height: 36,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 60,
                color: Colors.grey.withOpacity(0.2),
                child: const Icon(Icons.image_not_supported, color: Colors.grey),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCongratulationsOverlay() {
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
                translate('You completed the level!'),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        initializeGame();
                      });
                    },
                    child: Text(translate('Try Again')),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizLevelTwoScreen(),
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

class ItemPair {
  final String id;
  final String image;
  final String value;

  ItemPair({
    required this.id,
    required this.image,
    required this.value,
  });
} 