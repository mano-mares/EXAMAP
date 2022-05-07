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
  late Exam exam;
  List<Widget> questionButtonsList = [];

  List<bool> isChecked = [false, false, false];

  @override
  void initState() {
    super.initState();
    exam = getExam();

    print('-------');
    print(exam);
    for (int i = 0; i < exam.questions.length; i++) {
      questionButtonsList.add(questionButton(i));
    }
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
//        child: OpenQuestionForm(questionText: 'Wat is het zin van het leven?'),
        // child: CodeCorrectionForm(
        //     questionText: "system.out.println('hello'world);"),
        child: MultipleChoiceForm(
          questionText: exam.questions[2].questionText,
          answers: [
            Answer(answerText: 'c++', isCorrect: false),
            Answer(answerText: 'c--', isCorrect: true),
            Answer(answerText: 'c#', isCorrect: false),
          ],
        ),
      ),
    );
  }

  Form OpenQuestionForm({required String questionText}) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              questionText,
              style: const TextStyle(
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

  Form CodeCorrectionForm({required String questionText}) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          child: const Text(
            'Pas de code aan zodat dit zou werken.',
            style: TextStyle(
              fontSize: sizes.medium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          questionText,
          style: const TextStyle(
            fontSize: sizes.small,
            fontWeight: FontWeight.w200,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: 4,
          ),
        ),
      ],
    ));
  }

  Form MultipleChoiceForm(
      {required String questionText, required List<Answer> answers}) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              questionText,
              style: const TextStyle(
                fontSize: sizes.medium,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (int i = 0; i < answers.length; i++)
            checkboxAnswer(index: i, answerText: answers[i].answerText!)
        ],
      ),
    );
  }

  Widget checkboxAnswer({required int index, required String answerText}) {
    return Row(
      children: [
        Checkbox(
          value: isChecked[index],
          onChanged: (bool? value) {
            setState(
              () {
                isChecked[index] = value!;
              },
            );
          },
        ),
        Text(
          answerText,
          style: const TextStyle(
            fontSize: sizes.small,
          ),
        ),
      ],
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
      children: questionButtonsList,
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
