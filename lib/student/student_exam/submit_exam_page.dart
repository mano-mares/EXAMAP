import 'package:examap/main.dart';
import 'package:examap/models/exam.dart';
import 'package:examap/student/student_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:examap/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../res/style/my_fontsize.dart' as sizes;
import 'strings.dart' as strings;

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
  late FirebaseFirestore firestore;

  @override
  void initState() {
    Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    loadFirestore();
  }

  void loadFirestore() async {
    firestore = FirebaseFirestore.instance;
  }

  _submitExam() async {
    String studentNumber = StudentState.studentNumber.trim().toLowerCase();

    // Get students collection.
    final studentsRef = firestore
        .collection('dummy_data_examap')
        .doc('exam')
        .collection('students');

    // Loop through answers
    var answers = widget.answers;
    for (int i = 0; i < answers.length; i++) {
      var currentAnswer = answers[i];
      String questionId = currentAnswer[strings.id];
      dynamic answer;
      switch (currentAnswer[strings.questionType]) {
        case 'OQ':
          answer = <String, dynamic>{
            strings.maxPoint: currentAnswer[strings.maxPoint],
            strings.questionText: currentAnswer[strings.questionText],
            strings.questionType: currentAnswer[strings.questionType],
            strings.studentAnswer: currentAnswer[strings.studentAnswer],
          };
          break;
        case 'CC':
          answer = <String, dynamic>{
            strings.maxPoint: currentAnswer[strings.maxPoint],
            strings.questionText: currentAnswer[strings.questionText],
            strings.questionType: currentAnswer[strings.questionType],
            strings.studentAnswer: currentAnswer[strings.studentAnswer],
            strings.teacherAnswer: currentAnswer[strings.teacherAnswer],
          };
          break;
        case 'MC':
          answer = <String, dynamic>{
            strings.maxPoint: currentAnswer[strings.maxPoint],
            strings.questionText: currentAnswer[strings.questionText],
            strings.questionType: currentAnswer[strings.questionType],
            strings.studentAnswers:
                currentAnswer[strings.studentAnswers] as List<dynamic>,
            strings.teacherAnswers:
                currentAnswer[strings.teacherAnswers] as List<dynamic>,
          };
          break;
        default:
          break;
      }
      // Write answer to collection answers in student doc.
      try {
        await studentsRef
            .doc(studentNumber)
            .collection(strings.answers)
            .doc(questionId)
            .set(answer);
      } catch (e) {
        print('Something went wrong with send answers to firestore');
      }
    }

    // Go back to the main login page by replacing the page.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MyApp(),
      ),
    );

    // Clear studentnumber.
    StudentState.clear();
  }

  @override
  Widget build(BuildContext context) {
    //print("ANSWERS OF THE STUDENT");
    //print(widget.answers);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Examen indienen'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () async => await _submitExam(),
              child: const Text(
                'Indienen',
                style: TextStyle(fontSize: sizes.btnMedium),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding: const EdgeInsets.all(16.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
