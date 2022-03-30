import 'package:flutter/material.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body:
          Row(
            children: [
              RaisedButton(
                child: Text('Student'),
                onPressed: ChooseStudent,
              ),
              RaisedButton(
                child: Text('Docent'),
                onPressed: ChooseDocent
              )
            ]
          )
      ),
    );
  }
}
