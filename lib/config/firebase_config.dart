import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static const firebaseConfig = {
    'apiKey': 'AIzaSyCkcVV938kTH4RvvdjnRYTU94P_SYbTfcs',
    'authDomain': 'currency-champions.firebaseapp.com',
    'projectId': 'currency-champions',
    'storageBucket': 'currency-champions.firebasestorage.app',
    'messagingSenderId': '464672920512',
    'appId': '1:464672920512:web:708f656e0b420dc4f5ae25',
    'measurementId': 'G-3JSRQP032B',
  };

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: firebaseConfig['apiKey']!,
        authDomain: firebaseConfig['authDomain']!,
        projectId: firebaseConfig['projectId']!,
        storageBucket: firebaseConfig['storageBucket']!,
        messagingSenderId: firebaseConfig['messagingSenderId']!,
        appId: firebaseConfig['appId']!,
        measurementId: firebaseConfig['measurementId']!,
      ),
    );
  }
} 