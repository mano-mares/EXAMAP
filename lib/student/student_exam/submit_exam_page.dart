import 'package:examap/main.dart';
import 'package:flutter/material.dart';

import '../../res/style/my_fontsize.dart' as sizes;

class SubmitExamPage extends StatefulWidget {
  const SubmitExamPage({Key? key}) : super(key: key);

  @override
  State<SubmitExamPage> createState() => _SubmitExamPageState();
}

class _SubmitExamPageState extends State<SubmitExamPage> {
  @override
  Widget build(BuildContext context) {
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

  _submitExam() {
    // Go back to the main login page by replacing the page.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MyApp(),
      ),
    );
  }
}
