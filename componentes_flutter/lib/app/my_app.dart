import 'package:componentes_flutter/app/pages/form_page.dart';
import 'package:componentes_flutter/app/pages/home_page.dart';
import 'package:componentes_flutter/app/pages/login_page.dart';
import 'package:componentes_flutter/app/pages/tinder_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterando Materclass 14',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/tinder': (context) => const TinderPage(),
        '/login': (context) => const LoginPage(),
        '/form': (context) => const FormPage(),
      },
    );
  }
}
