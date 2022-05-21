import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:localstorage/localstorage.dart';
import 'package:asuka/asuka.dart' as asuka;
import 'pages/edit_maintenance.dart';
import 'pages/splash_page.dart';

final Storage storage = window.localStorage;
void main() async {
  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(const Aero());
}

class Aero extends StatelessWidget {
  const Aero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: asuka.builder,
      navigatorObservers: [
        asuka.asukaHeroController
      ],
      theme: ThemeData(primaryColor: const Color(0xFFEE7300),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFEE7300))),
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const SplashPage(),
        "/login":(context) => const LoginPage(),
        "/home": (context) => const HomePage(),
        "/edit_maintenance": (context) => const EditMaintenancePage(),
      },
    );
  }
}