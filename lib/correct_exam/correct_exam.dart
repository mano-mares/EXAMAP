import 'package:flutter/material.dart';

class CorrectExam extends StatefulWidget {
  const CorrectExam({Key? key}) : super(key: key);

  @override
  State<CorrectExam> createState() => _CorrectExamState();
}

class _CorrectExamState extends State<CorrectExam> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Correct exam',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Student'),
        ),
        body: Column(children: [
          Container(),
        ]),
      ),
    );
  }
}
