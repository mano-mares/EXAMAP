import 'package:flutter/material.dart';
import 'homepage_options/choose_option.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Choose type',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              child: const Text(
                "EXAMAP!",
                style: TextStyle(
                  fontSize: 55.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: const EdgeInsets.only(
                bottom: 100.0,
              ),
            ),
            Container(
              child: const Text(
                "Gelieve je rol te kiezen",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: const EdgeInsets.only(bottom: 100.0),
            ),
            ChooseOption(),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
