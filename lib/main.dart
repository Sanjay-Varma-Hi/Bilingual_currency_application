import 'package:flutter/material.dart';

void main() {
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
    );
  }
}

class CurrencyChampionsHome extends StatelessWidget {
  const CurrencyChampionsHome({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Currency Champions',
                style: TextStyle(
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
                                'Learn about Coins',
                                Colors.lightGreen[100]!,
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LearnCoinsScreen()),
                                ),
                              ),
                              _buildMenuButton(
                                'Learn about Bills',
                                Colors.lightGreen[100]!,
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LearnBillsScreen()),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildMenuButton(
                                'Play with Coins',
                                Colors.lightGreen[100]!,
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PlayCoinsScreen()),
                                ),
                              ),
                              _buildMenuButton(
                                'Play with Bills',
                                Colors.lightGreen[100]!,
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const PlayBillsScreen()),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildMenuButton(
                            'Take Quiz',
                            Color(0xFFE6C5B9),
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const QuizScreen()),
                            ),
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
          // Left side - Coin images
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
          // Right side - Coin information
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
    // Convert "1 Dollar" to "one", "2 Dollars" to "two", etc.
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
          // Left side - Bill images
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
          // Right side - Bill information
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

class PlayCoinsScreen extends StatelessWidget {
  const PlayCoinsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Spacer(flex: 2),  // Added more space at top
              const Text(
                'Coin Games',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB54B3C),
                ),
              ),
              const Spacer(flex: 2),  // Added space between title and buttons
              // Game option buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildGameButton('Name the Coin', () {
                    // Add navigation or game logic
                  }),
                  const SizedBox(height: 20),
                  _buildGameButton('Value of the Coin', () {
                    // Add navigation or game logic
                  }),
                  const SizedBox(height: 20),
                  _buildGameButton('Coin value conversion', () {
                    // Add navigation or game logic
                  }),
                ],
              ),
              const Spacer(flex: 3),  // Added more space before navigation
              // Navigation buttons at bottom
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      // Add previous screen navigation
                    },
                    color: Colors.black,
                    iconSize: 30,
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(
                      Icons.home,
                      size: 40,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      // Add next screen navigation
                    },
                    color: Colors.black,
                    iconSize: 30,
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE6C5B9),  // Light pink color
          foregroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 3,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class PlayBillsScreen extends StatelessWidget {
  const PlayBillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play with Bills'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(child: Text('Play Bills Screen')),
      ),
    );
  }
}

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Quiz'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(child: Text('Quiz Screen')),
      ),
    );
  }
}
