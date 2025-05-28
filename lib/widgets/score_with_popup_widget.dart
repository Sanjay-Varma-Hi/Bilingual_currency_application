import 'package:flutter/material.dart';
import 'score_widget.dart';
import '../globals/score.dart';

class ScoreWithPopupWidget extends StatefulWidget {
  const ScoreWithPopupWidget({super.key});

  @override
  State<ScoreWithPopupWidget> createState() => _ScoreWithPopupWidgetState();
}

class _ScoreWithPopupWidgetState extends State<ScoreWithPopupWidget> {
  final GlobalKey _scoreKey = GlobalKey();

  void _showScoreMenu() async {
    final RenderBox button = _scoreKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position = button.localToGlobal(Offset.zero, ancestor: overlay);
    final Size size = button.size;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + size.height + 8,
        overlay.size.width - position.dx - size.width,
        overlay.size.height - position.dy,
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          child: SizedBox(
            width: 240,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<Map<String, int>>(
                  valueListenable: GlobalScore.quizScores,
                  builder: (context, quizScores, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: quizScores.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  entry.key,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                entry.value.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                const Divider(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.refresh, size: 18),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[100],
                      foregroundColor: Colors.red[900],
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      GlobalScore.resetAllQuizScores();
                      GlobalScore.resetScore();
                      Navigator.of(context).pop();
                    },
                    label: const Text('Reset All'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _scoreKey,
      onTap: _showScoreMenu,
      child: const ScoreWidget(),
    );
  }
} 