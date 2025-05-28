import 'package:flutter/material.dart';
import '../widgets/score_with_popup_widget.dart';
import '../globals/score.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showScorePopup = false;
  final GlobalKey _scoreKey = GlobalKey();

  void _toggleScorePopup() {
    setState(() {
      _showScorePopup = !_showScorePopup;
    });
  }

  void _hideScorePopup() {
    if (_showScorePopup) {
      setState(() {
        _showScorePopup = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _hideScorePopup,
      child: Scaffold(
        body: Stack(
          children: [
            // ... existing code ...
            Positioned(
              top: 40,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    key: _scoreKey,
                    onTap: () {
                      _toggleScorePopup();
                    },
                    child: const ScoreWithPopupWidget(),
                  ),
                  if (_showScorePopup)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ValueListenableBuilder<double>(
                            valueListenable: GlobalScore.currentScore,
                            builder: (context, value, child) {
                              return Text(
                                'Your Score: \\${value.toStringAsFixed(1)} / \\${GlobalScore.maxScore.toStringAsFixed(1)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // ... existing code ...
          ],
        ),
      ),
    );
  }
} 