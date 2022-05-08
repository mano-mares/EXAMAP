import 'dart:async';

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
  late int currentQuestion;
  late Timer timer;
  late int startInSeconds;

  List<bool> isChecked = [false, false, false];

  @override
  void initState() {
    super.initState();
    exam = getExam();
    setState(() {
      currentQuestion = 0;
    });
    getStartTime(exam.timeLimit);
    startTimer();
  }

  // timeLimit format: "2:30 uur", "0:45 uur", "12:00 uur", etc.
  void getStartTime(String timeLimit) {
    // Split the string.
    dynamic time = timeLimit.split('uur')[0].split(':');
    int hour = int.parse(time[0]);
    int minute = int.parse(time[1]);

    // Convert hour and minutes to total seconds.
    Duration countdownDuration =
        Duration(hours: hour, minutes: minute, seconds: 0);
    startInSeconds = countdownDuration.inSeconds;
  }

  void startTimer() {
    // Timer ticking down a second.
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (startInSeconds == 0) {
          setState(() {
            timer.cancel();
            // TODO: show timer ended popup.
          });
        } else {
          setState(() {
            startInSeconds--;
          });
        }
      },
    );
  }

  // Format total seconds in HH:MM:SS
  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  Exam getExam() {
    // TODO: get exam from firestore.
    Exam dummyExam = Exam();
    dummyExam.subject = 'Intro Mobile';
    dummyExam.timeLimit = '0:1 uur';
    List<Question> questions = [
      for (int i = 0; i < 10; i++)
        OpenQuestion(
            id: '${i + 10}',
            questionText: 'Filler vraag $i',
            maxPoint: i + 5,
            questionType: 'Open vraag'),
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

  Widget questionForm() {
    Question question = exam.questions[currentQuestion];
    if (question is OpenQuestion) {
      return openQuestionForm(
        questionText: question.questionText,
        maxPoint: question.maxPoint,
      );
    } else if (question is CodeCorrectionQuestion) {
      return codeCorrectionForm(
        questionText: question.questionText,
        maxPoint: question.maxPoint,
      );
    } else if (question is MultipleChoiceQuestion) {
      return multipleChoiceForm(
          questionText: question.questionText,
          maxPoint: question.maxPoint,
          answers: question.possibleAnswers);
    } else {
      return const Text('Something went wrong...');
    }
  }

  Form openQuestionForm({required String questionText, required int maxPoint}) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              '${currentQuestion + 1}. $questionText ($maxPoint ptn.)',
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

  Form codeCorrectionForm(
      {required String questionText, required int maxPoint}) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            '${currentQuestion + 1}. Pas de code aan zodat dit zou werken. ($maxPoint ptn.)',
            style: const TextStyle(
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
            minLines: 10,
            maxLines: 10,
          ),
        ),
      ],
    ));
  }

  Form multipleChoiceForm(
      {required String questionText,
      required int maxPoint,
      required List<Answer> answers}) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              '${currentQuestion + 1}. $questionText ($maxPoint ptn.)',
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
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
      ),
    );
  }

  ElevatedButton nextQuestionButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          currentQuestion++;
        });
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

  ElevatedButton questionButton(int index) {
    return ElevatedButton(
      onPressed: () {
        setState(
          () {
            currentQuestion = index;
          },
        );
      },
      child: Text(
        '${index + 1}',
        style: const TextStyle(fontSize: sizes.btnXSmall),
      ),
      style: ElevatedButton.styleFrom(
        primary: currentQuestion == index
            ? const Color.fromARGB(255, 176, 6, 6)
            : Colors.red,
      ),
    );
  }

  Wrap questionButtons() {
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 8.0, // gap between lines
      children: <Widget>[
        for (int i = 0; i < exam.questions.length; i++) questionButton(i)
      ],
    );
  }

  Widget finishExamButton() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => showEndExamDialog(),
          child: const Text(
            "Beëindig het examen",
            style: TextStyle(fontSize: sizes.btnSmall),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            padding: const EdgeInsets.all(32.0),
          ),
        ),
      ],
    );
  }

  void showEndExamDialog() {
    showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Examen eindigen'),
        content: const Text(
            'Ben je zeker dat je je examen wilt indienen? Je kan het daarna niet meer aanpassen.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Sluit'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: end exam
            },
            child: const Text(
              "Examen indienen",
              style: TextStyle(fontSize: sizes.btnXSmall),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exam.subject),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            questionButtons(),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Resterende tijd: ${formatTime(startInSeconds)}',
                style: const TextStyle(fontSize: sizes.small),
              ),
            ),
            questionForm(),
            const SizedBox(height: 16.0),
            Column(
              children: [
                currentQuestion >= (exam.questions.length - 1)
                    ? finishExamButton()
                    : nextQuestionButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
