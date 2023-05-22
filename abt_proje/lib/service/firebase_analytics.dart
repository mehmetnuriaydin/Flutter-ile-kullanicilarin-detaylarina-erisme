import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver analyticsObserver = FirebaseAnalyticsObserver(analytics: analytics);

  /*static void setUserProperty(){
    analytics.setUserProperty(name: "category", value: category,)
  }*/
}
