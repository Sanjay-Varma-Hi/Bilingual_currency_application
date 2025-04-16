import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logButtonClick(String buttonName) async {
    await _analytics.logEvent(
      name: 'button_click',
      parameters: {
        'button_name': 'currency-$buttonName',
      },
    );
  }

  static Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenName,
    );
  }
} 