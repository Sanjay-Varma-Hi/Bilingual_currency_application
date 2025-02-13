import 'package:flutter/material.dart';

class LearnBillsScreen extends StatelessWidget {
  const LearnBillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Learn about Bills',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB54B3C),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
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
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/${imageName}_front.png',
                height: 60,
                width: 120,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 60,
                    width: 120,
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
                height: 60,
                width: 120,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 60,
                    width: 120,
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
          const SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bill Name - $billName',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Bill Value - $billValue',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 