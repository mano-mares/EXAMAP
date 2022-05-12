import 'package:examap/main.dart';
import 'package:examap/models/exam.dart';
import 'package:flutter/material.dart';

import '../../res/style/my_fontsize.dart' as sizes;

class SubmitExamPage extends StatefulWidget {
  final Exam exam;
  // The answers of the student in this list.
  final List<Map<String, dynamic>> answers;

  const SubmitExamPage({
    Key? key,
    required this.exam,
    required this.answers,
  }) : super(key: key);

  @override
  State<SubmitExamPage> createState() => _SubmitExamPageState();
}

class _SubmitExamPageState extends State<SubmitExamPage> {
  _submitExam() {
    // TODO: write answers to firestore.

    // Go back to the main login page by replacing the page.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MyApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("ANSWERS OF THE STUDENT");
    print(widget.answers);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Examen indienen'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Center(
              child: Text(
                'Overzicht vragen',
                style: TextStyle(
                  fontSize: sizes.medium,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _submitExam(),
              child: const Text(
                'Indienen',
                style: TextStyle(fontSize: sizes.btnMedium),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
