import 'package:abt_proje/helper/helper_function.dart';
import 'package:abt_proje/pages/home_page.dart';
import 'package:abt_proje/pages/auth/login_page.dart';
import 'package:abt_proje/service/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABT Proje',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [AnalyticsService.analyticsObserver],
      theme: ThemeData(colorScheme: ColorScheme.fromSwatch()),
      home: _isSignedIn ? HomePage() : LoginPage(),
    );
  }
}
