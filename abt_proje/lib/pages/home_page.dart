import 'package:abt_proje/pages/auth/login_page.dart';
import 'package:abt_proje/service/auth_service.dart';
import 'package:flutter/material.dart';

import 'dataScreens/display_choose_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 300),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 1, 135, 25),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  child: Text(
                    "Verilere Göz At",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DisplayChooseView()));
                  },
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    authService.signOut().then(
                        (value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage())));
                  },
                  child: Text("ÇIKIŞ")),
            ),
          ],
        ),
      ),
    );
  }
}
