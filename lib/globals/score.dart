import 'package:flutter/material.dart';

class GlobalScore {
  static final ValueNotifier<double> currentScore = ValueNotifier<double>(0.0);
  static const double maxScore = 5.0;

  static void addPoints(double points) {
    currentScore.value = (currentScore.value + points).clamp(0.0, maxScore);
  }

  static void resetScore() {
    currentScore.value = 0.0;
  }

  static String getFormattedScore() {
    return currentScore.value.toStringAsFixed(1);
  }
} 