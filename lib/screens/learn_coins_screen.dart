import 'package:flutter/material.dart';

class LearnCoinsScreen extends StatelessWidget {
  const LearnCoinsScreen({super.key});

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
                'Learn about Coins',
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
                      _buildCoinRow('Cent', '0.01\$ / 1 cent'),
                      _buildCoinRow('Nickel', '0.05\$ / 5 cents'),
                      _buildCoinRow('Dime', '0.10\$ / 10 cents'),
                      _buildCoinRow('Quarter', '0.25\$ / 25 cents'),
                      _buildCoinRow('Half Dollar', '0.5\$ / 50 cents'),
                      _buildCoinRow('Dollar', '1.0\$ / 100 cents'),
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

  Widget _buildCoinRow(String coinName, String coinValue) {
    String imageName = coinName.toLowerCase().replaceAll(' ', '');
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
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.monetization_on,
                    size: 60,
                    color: Colors.black87,
                  );
                },
              ),
              const SizedBox(width: 15),
              Image.asset(
                'assets/${imageName}_back.png',
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.monetization_on,
                    size: 60,
                    color: Colors.black87,
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
                'Coin Name - $coinName',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Coin Value - $coinValue',
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