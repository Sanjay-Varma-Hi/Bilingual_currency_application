import 'package:flutter/material.dart';
import 'screens/learn_coins_screen.dart';
import 'screens/learn_bills_screen.dart';
import 'screens/play_coins_screen.dart';
import 'screens/play_bills_screen.dart';
import 'screens/quiz_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'config/firebase_config.dart';
import 'services/analytics_service.dart';
import 'widgets/score_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Champions',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const CurrencyChampionsHome(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
      ],
    );
  }
}

class CurrencyChampionsHome extends StatefulWidget {
  const CurrencyChampionsHome({super.key});

  @override
  State<CurrencyChampionsHome> createState() => _CurrencyChampionsHomeState();
}

class _CurrencyChampionsHomeState extends State<CurrencyChampionsHome> {
  bool isSpanish = false;

  final Map<String, String> translations = {
    'Currency Champions': 'Campeones de la Moneda',
    'Learn about Coins': 'Aprende sobre Monedas',
    'Learn about Bills': 'Aprende sobre Billetes',
    'Play with Coins': 'Juega con Monedas',
    'Play with Bills': 'Juega con Billetes',
    'Take Quiz': 'Tomar Prueba',
  };

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreenView('HomeScreen');
  }

  String translate(String text) {
    if (!isSpanish) return text;
    return translations[text] ?? text;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    translate('Currency Champions'),
                    style: const TextStyle(
                      fontSize: 40,
                      fontFamily: 'serif',
                      color: Color(0xFFB54B3C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: isTablet ? 600 : screenSize.width * 0.9,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildMenuButton(
                                    translate('Learn about Coins'),
                                    Colors.lightGreen[100]!,
                                    () {
                                      AnalyticsService.logButtonClick('LearnCoins');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const LearnCoinsScreen()),
                                      );
                                    },
                                  ),
                                  _buildMenuButton(
                                    translate('Learn about Bills'),
                                    Colors.lightGreen[100]!,
                                    () {
                                      AnalyticsService.logButtonClick('LearnBills');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const LearnBillsScreen()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildMenuButton(
                                    translate('Play with Coins'),
                                    Colors.lightGreen[100]!,
                                    () {
                                      AnalyticsService.logButtonClick('PlayCoins');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const PlayCoinsScreen()),
                                      );
                                    },
                                  ),
                                  _buildMenuButton(
                                    translate('Play with Bills'),
                                    Colors.lightGreen[100]!,
                                    () {
                                      AnalyticsService.logButtonClick('PlayBills');
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const PlayBillsScreen()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              _buildMenuButton(
                                translate('Take Quiz'),
                                const Color(0xFFE6C5B9),
                                () {
                                  AnalyticsService.logButtonClick('TakeQuiz');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const QuizScreen()),
                                  );
                                },
                                width: 200,
                              ),
                              const SizedBox(height: 40),
                              SizedBox(
                                height: 250,
                                width: double.infinity,
                                child: Image.asset(
                                  'assets/home1.png',
                                  fit: BoxFit.contain,
                                  scale: 0.8,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.image,
                                      size: 50,
                                      color: Colors.grey,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                    AnalyticsService.logButtonClick('Translate');
                    setState(() {
                      isSpanish = !isSpanish;
                    });
                  },
                ),
                const SizedBox(height: 8),
                const ScoreWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(String text, Color color, VoidCallback onPressed, {double? width}) {
    return SizedBox(
      width: width ?? 180,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 3,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
