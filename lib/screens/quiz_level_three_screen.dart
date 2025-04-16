import 'package:flutter/material.dart';
import 'dart:math';

class QuizLevelThreeScreen extends StatefulWidget {
  const QuizLevelThreeScreen({super.key});

  @override
  State<QuizLevelThreeScreen> createState() => _QuizLevelThreeScreenState();
}

class _QuizLevelThreeScreenState extends State<QuizLevelThreeScreen> {
  double targetAmount = 0.0;
  Map<String, int> selectedCoins = {
    'penny': 0,
    'nickel': 0,
    'dime': 0,
    'quarter': 0,
    'one': 0,
    'five': 0,
    'ten': 0,
  };
  
  Map<String, double> coinValues = {
    'penny': 0.01,
    'nickel': 0.05,
    'dime': 0.10,
    'quarter': 0.25,
    'one': 1.00,
    'five': 5.00,
    'ten': 10.00,
  };

  Map<String, String> translations = {
    'Make': 'Hacer',
    'Current Total': 'Total Actual',
    'Check Answer': 'Verificar Respuesta',
    'Reset': 'Reiniciar',
    'Correct!': '¡Correcto!',
    'Try Again': 'Intenta de Nuevo',
    'Next Amount': 'Siguiente Cantidad',
  };

  bool isSpanish = false;
  bool isCorrect = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    generateNewTarget();
  }

  String translate(String text) {
    if (!isSpanish) return text;
    return translations[text] ?? text;
  }

  void generateNewTarget() {
    final random = Random();
    // Generate amount between $0.01 and $9.99
    targetAmount = (random.nextInt(999) + 1) / 100;
    resetSelections();
  }

  void resetSelections() {
    setState(() {
      selectedCoins.updateAll((key, value) => 0);
      isCorrect = false;
    });
  }

  double getCurrentTotal() {
    double total = 0;
    selectedCoins.forEach((coin, count) {
      total += coinValues[coin]! * count;
    });
    return total;
  }

  void checkAnswer() {
    double total = getCurrentTotal();
    setState(() {
      isCorrect = (total == targetAmount);
      if (isCorrect) {
        score += 10;
      }
    });
  }

  Widget buildCoinSelector(String coinName, String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 10),
          Text('${coinValues[coinName]!.toStringAsFixed(2)}\$'),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: selectedCoins[coinName] == 0 ? null : () {
              setState(() {
                selectedCoins[coinName] = selectedCoins[coinName]! - 1;
              });
            },
          ),
          Text('${selectedCoins[coinName]}'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                selectedCoins[coinName] = selectedCoins[coinName]! + 1;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level 3'),
        actions: [
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () {
              setState(() {
                isSpanish = !isSpanish;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '${translate('Make')}: \$${targetAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              '${translate('Current Total')}: \$${getCurrentTotal().toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                color: getCurrentTotal() > targetAmount ? Colors.red : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildCoinSelector('penny', 'assets/cent_front.png'),
                    buildCoinSelector('nickel', 'assets/nickel_front.png'),
                    buildCoinSelector('dime', 'assets/dime_front.png'),
                    buildCoinSelector('quarter', 'assets/quarter_front.png'),
                    buildCoinSelector('one', 'assets/one_front.png'),
                    buildCoinSelector('five', 'assets/five_front.png'),
                    buildCoinSelector('ten', 'assets/ten_front.png'),
                  ],
                ),
              ),
            ),
            Text(
              'Score: $score',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: checkAnswer,
                  child: Text(translate('Check Answer')),
                ),
                ElevatedButton(
                  onPressed: resetSelections,
                  child: Text(translate('Reset')),
                ),
              ],
            ),
            if (isCorrect) ...[
              const SizedBox(height: 20),
              Text(
                translate('Correct!'),
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: generateNewTarget,
                child: Text(translate('Next Amount')),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 