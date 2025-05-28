import 'package:flutter/material.dart';
import '../widgets/score_with_popup_widget.dart';

class LearnBillsScreen extends StatefulWidget {
  const LearnBillsScreen({super.key});

  @override
  _LearnBillsScreenState createState() => _LearnBillsScreenState();
}

class _LearnBillsScreenState extends State<LearnBillsScreen> {
  bool isSpanish = false;

  final Map<String, String> translations = {
    'Learn about Bills': 'Aprende sobre Billetes',
    'Bill Name - ': 'Nombre del Billete - ',
    'Bill Value - ': 'Valor del Billete - ',
    '1 Dollar': '1 Dólar',
    '2 Dollars': '2 Dólares',
    '5 Dollars': '5 Dólares',
    '10 Dollars': '10 Dólares',
    '20 Dollars': '20 Dólares',
    '50 Dollars': '50 Dólares',
    '100 Dollars': '100 Dólares',
    '1 \$ / 100 cents': '1 \$ / 100 centavos',
    '2 \$ / 200 cents': '2 \$ / 200 centavos',
    '5 \$ / 500 cents': '5 \$ / 500 centavos',
    '10 \$ / 1000 cents': '10 \$ / 1000 centavos',
    '20 \$ / 2000 cents': '20 \$ / 2000 centavos',
    '50 \$ / 5000 cents': '50 \$ / 5000 centavos',
    '100 \$ / 10,000 cents': '100 \$ / 10,000 centavos',
  };

  String translate(String text) {
    if (!isSpanish) return text;
    return translations[text] ?? text;
  }

  @override
  Widget build(BuildContext context) {
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
                    translate('Learn about Bills'),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB54B3C),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: ListView(
                        children: [
                          _buildBillRow('1 Dollar', '1 \$ / 100 cents'),
                          _buildBillRow('2 Dollars', '2 \$ / 200 cents'),
                          _buildBillRow('5 Dollars', '5 \$ / 500 cents'),
                          _buildBillRow('10 Dollars', '10 \$ / 1000 cents'),
                          _buildBillRow('20 Dollars', '20 \$ / 2000 cents'),
                          _buildBillRow('50 Dollars', '50 \$ / 5000 cents'),
                          _buildBillRow('100 Dollars', '100 \$ / 10,000 cents'),
                        ],
                      ),
                    ),
                  ),
                  Center(
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
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: Column(
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
                const ScoreWithPopupWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(String billName, String billValue) {
    String getImagePrefix(String name) {
      final number = name.split(' ')[0];
      switch (number) {
        case '1': return 'one';
        case '2': return 'two';
        case '5': return 'five';
        case '10': return 'ten';
        case '20': return 'twenty';
        case '50': return 'fifty';
        case '100': return 'hundred';
        default: return number.toLowerCase();
      }
    }

    String imageName = getImagePrefix(billName);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/${imageName}_front.png',
                height: 80,
                width: 160,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 80,
                    width: 160,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.attach_money,
                      size: 40,
                      color: Colors.black87,
                    ),
                  );
                },
              ),
              const SizedBox(width: 15),
              Image.asset(
                'assets/${imageName}_back.png',
                height: 80,
                width: 160,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 80,
                    width: 160,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.attach_money,
                      size: 40,
                      color: Colors.black87,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(width: 60),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translate('Bill Name - ') + translate(billName),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  translate('Bill Value - ') + translate(billValue),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
} 