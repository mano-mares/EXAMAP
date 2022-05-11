import 'package:examap/student/choose_student_number/students.dart';
import 'package:flutter/material.dart';

class CorrectExam extends StatefulWidget {
  const CorrectExam({Key? key, this.studentNumber}) : super(key: key);

  @override
  State<CorrectExam> createState() => _CorrectExamState();

  final studentNumber;
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
        body: Column(
          children: [
            Container(
              child: Text(widget.studentNumber),
            ),
          ],
        ),
      ),
    );
  }
}
