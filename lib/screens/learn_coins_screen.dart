import 'package:flutter/material.dart';
import '../widgets/score_with_popup_widget.dart';

class LearnCoinsScreen extends StatefulWidget {
  const LearnCoinsScreen({super.key});

  @override
  _LearnCoinsScreenState createState() => _LearnCoinsScreenState();
}

class _LearnCoinsScreenState extends State<LearnCoinsScreen> {
  bool isSpanish = false;

  // Translation maps
  final Map<String, String> translations = {
    'Learn about Coins': 'Aprende sobre Monedas',
    'Coin Name - ': 'Nombre de la Moneda - ',
    'Coin Value - ': 'Valor de la Moneda - ',
    'Cent': 'Centavo',
    'Nickel': 'Níquel',
    'Dime': 'Diez Centavos',
    'Quarter': 'Cuarto de Dólar',
    'Half Dollar': 'Medio Dólar',
    'Dollar': 'Dólar',
    '0.01\$ / 1 cent': '0.01\$ / 1 centavo',
    '0.05\$ / 5 cents': '0.05\$ / 5 centavos',
    '0.10\$ / 10 cents': '0.10\$ / 10 centavos',
    '0.25\$ / 25 cents': '0.25\$ / 25 centavos',
    '0.5\$ / 50 cents': '0.50\$ / 50 centavos',
    '1.0\$ / 100 cents': '1.00\$ / 100 centavos',
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
                    translate('Learn about Coins'),
                    style: const TextStyle(
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
                translate('Coin Name - ') + translate(coinName),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                translate('Coin Value - ') + translate(coinValue),
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