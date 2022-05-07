import 'package:examap/models/exam.dart';
import 'package:examap/models/questions/code_correction/code_correction_question.dart';
import 'package:examap/models/questions/multiple_choice/answer.dart';
import 'package:examap/models/questions/multiple_choice/multiple_choice_question.dart';
import 'package:examap/models/questions/open_question/open_question.dart';
import 'package:examap/models/questions/question.dart';
import 'package:flutter/material.dart';

class StudentExam extends StatefulWidget {
  const StudentExam({Key? key}) : super(key: key);

  @override
  State<StudentExam> createState() => _StudentExamState();
}

class _StudentExamState extends State<StudentExam> {
  Exam? exam;

  @override
  void initState() {
    super.initState();
    exam = getExam();
    print('-------');
    print(exam);
  }

  Exam getExam() {
    // TODO: get exam from firestore.
    Exam dummyExam = Exam();
    dummyExam.subject = 'Intro Mobile';
    dummyExam.timeLimit = '2:30';
    List<Question> questions = [
      OpenQuestion(
        id: '1',
        questionText: 'Leg het verschil uit tussen een stack en een heap.',
        maxPoint: 5,
        questionType: 'Open vraag',
      ),
      CodeCorrectionQuestion(
        id: '2',
        questionText: "console('hello')",
        answerText: "console.log('hello')",
        maxPoint: 3,
        questionType: 'Code correctie',
      ),
      MultipleChoiceQuestion(
        id: '3',
        questionText: 'Wat is geen programmeertaal?',
        maxPoint: 2,
        questionType: 'Meerkeuze',
        possibleAnswers: [
          Answer(answerText: 'c++', isCorrect: false),
          Answer(answerText: 'c--', isCorrect: true),
          Answer(answerText: 'c#', isCorrect: false),
        ],
      ),
    ];
    dummyExam.questions = questions;
    return dummyExam;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Examen'),
      ),
      body: Text('examen maken'),
    );
  }
}
