import 'package:flutter/material.dart';
import 'HomePage/ChooseOption.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // Moet nog veranderd worden naar ChooseType()
  void ChooseStudent() {
    print('Student chosen');
  }

  void ChooseDocent() {
    print('Docent chosen');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Choose type',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Column(
        children: [
          Container(
            child: Text(
              "EXAMAP!",
              style: new TextStyle(
                fontSize: 55.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: EdgeInsets.only(
              bottom: 100.0,
            ),
          ),
          Container(
            child: Text(
              "Gelieve je rol te kiezen",
              style: new TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: EdgeInsets.only(bottom: 100.0),
          ),
          ChooseOption(),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      )),
    );
  }
}
