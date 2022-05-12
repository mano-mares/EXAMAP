import 'dart:async';

import 'package:examap/models/exam.dart';
import 'package:examap/models/questions/code_correction/code_correction_question.dart';
import 'package:examap/models/questions/multiple_choice/answer.dart';
import 'package:examap/models/questions/multiple_choice/multiple_choice_question.dart';
import 'package:examap/models/questions/open_question/open_question.dart';
import 'package:examap/models/questions/question.dart';
import 'package:examap/student/student_exam/submit_exam_page.dart';
import 'package:flutter/material.dart';

import '../../res/style/my_fontsize.dart' as sizes;

class StudentExam extends StatefulWidget {
  const StudentExam({Key? key}) : super(key: key);

  @override
  State<StudentExam> createState() => _StudentExamState();
}

class _StudentExamState extends State<StudentExam> {
  final TextEditingController openQuestionController = TextEditingController();
  final TextEditingController codeCorrectionController =
      TextEditingController();

  // The exam that the student will fill in.
  Exam? _exam;

  // Timer of the exam.
  Timer? _timer;
  int? _counterInSeconds;

  // All the questions of the exam.
  List<Question>? _questions;
  // Current question student is right now.
  Question? _currentQuestion;
  // Index of the current question of the exam.
  int? _currentQuestionIndex;
  // The answers of the student in this list.
  List<Map<String, dynamic>>? _answers;

  // The state of the MC answers of the student.
  List<bool>? _isChecked;

  @override
  void initState() {
    super.initState();
    _exam ??= getExam();
    _questions ??= _exam?.questions;
    int? counterInSeconds = getStartTimeInSeconds(_exam!.timeLimit);
    setState(() {
      // Assign 0 to _currentQuestion if _currentQuestion is null.
      _currentQuestionIndex ??= 0;
      // set the current question.
      _currentQuestion ??= _questions![_currentQuestionIndex!];

      // Start value of the timer of the exam.
      _counterInSeconds ??= counterInSeconds;

      // Initial state of the text fields are empty.
      openQuestionController.text = "";
      codeCorrectionController.text = "";
      // Initial state of the checkboxes are unchecked.
      _isChecked ??= [false, false, false];

      // Set empty answers of the student.
      _answers ??= [];
    });
    startTimer();
  }

  // TimeLimit format: "2:30 uur", "0:45 uur", "12:00 uur", etc.
  int getStartTimeInSeconds(String timeLimit) {
    // Split the string.
    dynamic time = timeLimit.split('uur')[0].split(':');
    int hour = int.parse(time[0]);
    int minute = int.parse(time[1]);

    // Convert hour and minutes to total seconds.
    Duration countdownDuration =
        Duration(hours: hour, minutes: minute, seconds: 0);
    return countdownDuration.inSeconds;
  }

  // A timer that is ticking down a second.
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_counterInSeconds! <= 0) {
          setState(() {
            timer.cancel();
          });

          // Show snackbar that the timer has run out.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Tijd is op!"),
              duration: Duration(milliseconds: 3000),
              behavior: SnackBarBehavior.floating,
            ),
          );

          // Go to submit exam.
          goToEndExamPage();
        } else {
          setState(() {
            // Decrease the counter.
            _counterInSeconds = _counterInSeconds! - 1;
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
    dummyExam.timeLimit = '0:10 uur';
    List<Question> questions = [
      // for (int i = 0; i < 3; i++)
      //   OpenQuestion(
      //       id: '${i + 10}',
      //       questionText: 'Filler vraag $i',
      //       maxPoint: i + 5,
      //       questionType: 'OQ'),
      OpenQuestion(
        id: '1',
        questionText: 'Leg het verschil uit tussen een stack en een heap.',
        maxPoint: 5,
        questionType: 'OQ',
      ),
      CodeCorrectionQuestion(
        id: '2',
        questionText: "console('hello')",
        answerText: "console.log('hello')",
        maxPoint: 3,
        questionType: 'CC',
      ),
      CodeCorrectionQuestion(
        id: '2',
        questionText: "MAIN",
        answerText: "main",
        maxPoint: 15,
        questionType: 'CC',
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
      MultipleChoiceQuestion(
        id: '3',
        questionText: 'Wat is een dier?',
        maxPoint: 2,
        questionType: 'MC',
        possibleAnswers: [
          Answer(answerText: 'hond', isCorrect: true),
          Answer(answerText: 'kast', isCorrect: false),
          Answer(answerText: 'muur', isCorrect: false),
        ],
      ),
      MultipleChoiceQuestion(
        id: '3',
        questionText: 'Wat is wel een programmeertaal?',
        maxPoint: 5,
        questionType: 'MC',
        possibleAnswers: [
          Answer(answerText: 'rattlesnake', isCorrect: false),
          Answer(answerText: 'anaconda', isCorrect: false),
          Answer(answerText: 'python', isCorrect: true),
        ],
      ),
    ];
    dummyExam.questions = questions;
    return dummyExam;
  }

  Widget questionForm() {
    _currentQuestion = _questions?[_currentQuestionIndex!];
    if (_currentQuestion is OpenQuestion) {
      _currentQuestion = _currentQuestion as OpenQuestion;
      return openQuestionForm();
    } else if (_currentQuestion is CodeCorrectionQuestion) {
      _currentQuestion = _currentQuestion as CodeCorrectionQuestion;
      return codeCorrectionForm();
    } else if (_currentQuestion is MultipleChoiceQuestion) {
      _currentQuestion = _currentQuestion as MultipleChoiceQuestion;
      return multipleChoiceForm();
    } else {
      return const Text('Something went wrong...');
    }
  }

  Form openQuestionForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              '${_currentQuestionIndex! + 1}. ${_currentQuestion!.questionText} (${_currentQuestion!.maxPoint} ptn.)',
              style: const TextStyle(
                fontSize: sizes.medium,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: openQuestionController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.multiline,
            minLines: 10,
            maxLines: 10,
          ),
          const SizedBox(height: 16.0),
          Column(
            children: [
              _currentQuestionIndex! >= (_questions!.length - 1)
                  ? finishExamButton()
                  : nextQuestionButton(),
            ],
          ),
        ],
      ),
    );
  }

  Form codeCorrectionForm() {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            '${_currentQuestionIndex! + 1}. Pas de code aan zodat dit zou werken. (${_currentQuestion!.maxPoint} ptn.)',
            style: const TextStyle(
              fontSize: sizes.medium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          _currentQuestion!.questionText,
          style: const TextStyle(
            fontSize: sizes.small,
            fontWeight: FontWeight.w200,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: TextFormField(
            controller: codeCorrectionController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.multiline,
            minLines: 10,
            maxLines: 10,
          ),
        ),
        const SizedBox(height: 16.0),
        Column(
          children: [
            _currentQuestionIndex! >= (_questions!.length - 1)
                ? finishExamButton()
                : nextQuestionButton(),
          ],
        ),
      ],
    ));
  }

  Form multipleChoiceForm() {
    MultipleChoiceQuestion currentQuestion =
        _currentQuestion as MultipleChoiceQuestion;
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              '${_currentQuestionIndex! + 1}. ${currentQuestion.questionText} (${currentQuestion.maxPoint} ptn.)',
              style: const TextStyle(
                fontSize: sizes.medium,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          for (int i = 0; i < currentQuestion.possibleAnswers.length; i++)
            checkboxAnswer(
                index: i,
                answerText: currentQuestion.possibleAnswers[i].answerText!),
          const SizedBox(height: 16.0),
          Column(
            children: [
              _currentQuestionIndex! >= (_questions!.length - 1)
                  ? finishExamButton()
                  : nextQuestionButton(),
            ],
          ),
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
            value: _isChecked![index],
            onChanged: (bool? value) {
              setState(() {
                // Set the state of the MC checkboxes.
                _isChecked![index] = value!;
              });
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

  // Store/update the answers of the student.
  void updateAnswers() {
    // 1. Check if the answer is already in the list.
    String? foundId;
    final id = "question_${_currentQuestionIndex! + 1}";
    print('Find question with id $id');
    for (var map in _answers!) {
      if (map.containsKey("id")) {
        if (map["id"] == id) {
          // 2.1 If so, change the answer in the list.
          foundId ??= id;
          print('Found question with id $id');
          return;
        }
      }
    }

    // _answers?.removeWhere((map) {
    //   return map["id"] == foundId;
    // });

    // 2.2 If not, append the answer to the list.
    Map<String, dynamic> json = {};
    switch (_currentQuestion!.questionType) {
      case 'OQ':
        OpenQuestion currentQuestion = _currentQuestion as OpenQuestion;
        json = {
          'id': id,
          'max_point': currentQuestion.maxPoint,
          'question_text': currentQuestion.questionText,
          'student_answer': openQuestionController.text,
          'type': currentQuestion.questionType,
        };
        break;
      case 'CC':
        CodeCorrectionQuestion currentQuestion =
            _currentQuestion as CodeCorrectionQuestion;
        json = {
          'id': id,
          'max_point': currentQuestion.maxPoint,
          'question_text': currentQuestion.questionText,
          'student_answer': codeCorrectionController.text,
          'teacher_answer': currentQuestion.answerText,
          'type': currentQuestion.questionType,
        };
        break;
      case 'MC':
        MultipleChoiceQuestion currentQuestion =
            _currentQuestion as MultipleChoiceQuestion;
        // Create a mapping of the answers of the student.
        List<Map<String, dynamic>> studentAnswers = [];
        for (int i = 0; i < currentQuestion.possibleAnswers.length; i++) {
          Map<String, dynamic> studentAnswer = {
            'answer_text': currentQuestion.possibleAnswers[i].answerText,
            'student_answer': _isChecked![i],
          };

          studentAnswers.add(studentAnswer);
        }
        json = {
          'id': id,
          'type': currentQuestion.questionType,
          'student_answers': studentAnswers,
          'teacher_answers': currentQuestion.possibleAnswers,
        };
        break;
      default:
        break;
    }

    setState(() {
      _answers!.add(json);
      print('---ANSWERS---');
      print(_answers);

      _currentQuestionIndex = _currentQuestionIndex! + 1;
      // // Get the current question.
      // _currentQuestion = _questions?[_currentQuestionIndex!];

      //print("current question is $_currentQuestion");
      // print('CURRENT INDEX IS $_currentQuestionIndex');
      // print("current question is $_currentQuestion");

      //setAnswer(_currentQuestionIndex!);
    });
  }

  ElevatedButton nextQuestionButton() {
    return ElevatedButton(
      onPressed: () {
        updateAnswers();
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

  void setAnswer(int index) {
    String? foundId;
    String? foundType;
    String id = "question_${index + 1}";
    // Check if the answer is already stored.
    for (var map in _answers!) {
      if (map.containsKey("id")) {
        if (map["id"] == id) {
          foundId = id;
          foundType = map["type"];
          print("Found answer $foundId");
          break;
        }
      }
    }

    // Exit if not already answered.
    if (foundId == null) {
      print("Clear text field");
      // Clear the text field.
      openQuestionController.text = "";
      codeCorrectionController.text = "";
      _isChecked = [false, false, false];
      return;
    }

    print('get answer from $foundType');

    switch (foundType) {
      case 'OQ':
        Map<String, dynamic> getAnswer =
            _answers!.where((element) => element["id"] == id).first;
        String answer = getAnswer["student_answer"];
        print(answer);
        openQuestionController.text = answer;
        break;
      case 'CC':
        Map<String, dynamic> getAnswer =
            _answers!.where((element) => element["id"] == id).first;
        String answer = getAnswer["student_answer"];
        print(answer);
        codeCorrectionController.text = answer;
        break;
      case 'MC':
        // TODO: do this.
        print("IN MC");
        Map<String, dynamic> getAnswer =
            _answers!.where((element) => element["id"] == id).first;
        List<Map<String, dynamic>> getStudentAnswersMultipleChoice =
            getAnswer["student_answers"];
        print(getStudentAnswersMultipleChoice);
        for (int i = 0; i < getStudentAnswersMultipleChoice.length; i++) {
          _isChecked![i] = getStudentAnswersMultipleChoice[i]["answer"];
        }
        break;
      default:
    }

    // If there is an answer, set the text field
  }

  ElevatedButton questionButton(int index) {
    return ElevatedButton(
      onPressed: () {
        setState(
          () {
            print("Go to question $index");
            _currentQuestionIndex = index;
            // TODO: if already answered, show the answer in the text field from the answers list.
            //_updateAnswers(index, studentAnswer, questionType, possibleAnswers);
            //setAnswer(_currentQuestionIndex!);
          },
        );
      },
      child: Text(
        '${index + 1}',
        style: const TextStyle(fontSize: sizes.btnXSmall),
      ),
      style: ElevatedButton.styleFrom(
        primary: _currentQuestionIndex == index
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
        for (int i = 0; i < _questions!.length; i++) questionButton(i)
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
    // TODO: sort the answers.
    showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Examen eindigen'),
        content: const Text(
            'Ben je zeker dat je je examen wilt indienen? Je kan het daarna niet meer aanpassen.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Sluit'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              goToEndExamPage();
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

  void goToEndExamPage() {
    // Push new page and remove all previous pages
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SubmitExamPage()),
        ((route) => false));
  }

  @override
  Widget build(BuildContext context) {
    // print('CURRENT INDEX IS $_currentQuestionIndex');
    // print("current question is $_currentQuestion");
    return Scaffold(
      appBar: AppBar(
        title: Text(_exam!.subject),
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
                'Resterende tijd: ${formatTime(_counterInSeconds!)}',
                style: const TextStyle(fontSize: sizes.small),
              ),
            ),
            questionForm(),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    openQuestionController.dispose();
    codeCorrectionController.dispose();
    super.dispose();
  }
}
