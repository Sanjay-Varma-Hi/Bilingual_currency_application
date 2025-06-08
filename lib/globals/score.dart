import 'package:flutter/material.dart';

class GlobalScore {
  static final ValueNotifier<double> currentScore = ValueNotifier<double>(0.0);
  static const double maxScore = 5.0;
  static final Set<String> awardedScores = {};

  // Per-quiz scores
  static final ValueNotifier<Map<String, int>> quizScores = ValueNotifier<Map<String, int>>({
    'Name the Coin': 0,
    'Value of the Coin': 0,
    'Coin Value Conversion': 0,
    'Name the Bill': 0,
    'Value of the Bill': 0,
    'Bill Value Conversion': 0,
    'Level 1': 0,
    'Level 2': 0,
    'Level 3': 0,
    'Level 4': 0,
  });

  static void addPoints(double points) {
    currentScore.value = (currentScore.value + points).clamp(0.0, maxScore);
  }

  static void resetScore() {
    currentScore.value = 0.0;
    awardedScores.clear();
  }

  static String getFormattedScore() {
    return currentScore.value.toStringAsFixed(1);
  }

  // Update a specific quiz score
  static void updateQuizScore(String quizName, int score) {
    final updated = Map<String, int>.from(quizScores.value);
    updated[quizName] = score;
    quizScores.value = updated;
  }

  // Reset all quiz scores
  static void resetAllQuizScores() {
    quizScores.value = quizScores.value.map((k, v) => MapEntry(k, 0));
    awardedScores.clear();
  }

  // Check if a score has been awarded
  static bool hasBeenAwarded(String quizName) {
    return awardedScores.contains(quizName);
  }

  // Mark a score as awarded
  static void markAsAwarded(String quizName) {
    awardedScores.add(quizName);
  }
} 