import 'package:examap/models/exam.dart';
import 'package:examap/models/questions/code_correction/code_correction_question.dart';
import 'package:examap/models/questions/multiple_choice/answer.dart';
import 'package:examap/models/questions/multiple_choice/multiple_choice_question.dart';
import 'package:examap/models/questions/open_question/open_question.dart';
import 'package:examap/models/questions/question.dart';
import 'package:flutter/material.dart';

import '../../res/style/my_fontsize.dart' as sizes;

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

  Container QuestionContainer() {
    return Container(
      //color: const Color.fromARGB(255, 245, 241, 241),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: OpenQuestionForm(),
      ),
    );
  }

  Form OpenQuestionForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: const Text(
              'Wat is het zin van het leven?',
              style: TextStyle(
                fontSize: sizes.medium,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.multiline,
            minLines: 10,
            maxLines: 10,
          ),
        ],
      ),
    );
  }

  ElevatedButton nextQuestionButton() {
    return ElevatedButton(
      onPressed: () {
        // TODO: go to next question.
      },
      child: const Text(
        "Volgende vraag",
        style: TextStyle(fontSize: sizes.btnSmall),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        padding: const EdgeInsets.all(32.0),
      ),
    );
  }

  Widget questionButton(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // TODO: go to question with that index.
        },
        child: Text(
          '${index + 1}',
          style: const TextStyle(fontSize: sizes.btnXSmall),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.redAccent,
        ),
      ),
    );
  }

  Row questionButtons() {
    return Row(
      children: [
        questionButton(0),
        questionButton(1),
        questionButton(2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${exam?.subject}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            questionButtons(),
            Container(
              margin: const EdgeInsets.only(top: 16.0, bottom: 32.0),
              child: Expanded(
                child: QuestionContainer(),
              ),
            ),
            Column(
              children: [
                nextQuestionButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
