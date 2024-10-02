import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:postly/ui/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        navigationBarTheme: const NavigationBarThemeData(
            backgroundColor: Colors.black,
            indicatorColor: Colors.transparent,
            labelTextStyle: WidgetStatePropertyAll(
              TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            )),
      ),
      home: const HomeScreen(),
    );
  }
}
