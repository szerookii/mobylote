import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobylote/views/home/home.dart';
import 'package:mobylote/views/login/ask_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  initializeDateFormatting('fr_FR', null);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

Future<String?> _checkStoredId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('id');
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobylote',
      theme: ThemeData.dark(),
      home: FutureBuilder<String?>(
        future: _checkStoredId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.hasError) {
            return const AskCodePage();
          } else if (snapshot.hasData && snapshot.data != null) {
            return HomePage(id: snapshot.data!);
          } else {
            return const AskCodePage();
          }
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
