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
  late Exam exam;
  late int currentQuestion;
  late Timer timer;
  late int startInSeconds;
  late List<Map<String, dynamic>> _answers;
  final TextEditingController openQuestionController = TextEditingController();
  final TextEditingController codeCorrectionController =
      TextEditingController();

  List<bool> isChecked = [false, false, false];

  @override
  void initState() {
    super.initState();
    exam = getExam();
    setState(() {
      currentQuestion = 0;
      _answers = [];
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
          });
          // Show snackbar
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
    dummyExam.timeLimit = '0:10 uur';
    List<Question> questions = [
      for (int i = 0; i < 3; i++)
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
      CodeCorrectionQuestion(
        id: '2',
        questionText: "MAIN",
        answerText: "main",
        maxPoint: 15,
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
      MultipleChoiceQuestion(
        id: '3',
        questionText: 'Wat is een dier?',
        maxPoint: 2,
        questionType: 'Meerkeuze',
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
        questionType: 'Meerkeuze',
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
    Question question = exam.questions[currentQuestion];
    if (question is OpenQuestion) {
      return openQuestionForm(
        questionText: question.questionText,
        maxPoint: question.maxPoint,
        index: currentQuestion,
        controller: openQuestionController,
      );
    } else if (question is CodeCorrectionQuestion) {
      return codeCorrectionForm(
        questionText: question.questionText,
        maxPoint: question.maxPoint,
        index: currentQuestion,
        controller: codeCorrectionController,
      );
    } else if (question is MultipleChoiceQuestion) {
      return multipleChoiceForm(
          questionText: question.questionText,
          maxPoint: question.maxPoint,
          index: currentQuestion,
          possibleAnswers: question.possibleAnswers);
    } else {
      return const Text('Something went wrong...');
    }
  }

  Form openQuestionForm({
    required String questionText,
    required int maxPoint,
    required int index,
    required TextEditingController controller,
  }) {
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
            controller: controller,
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
              currentQuestion >= (exam.questions.length - 1)
                  ? finishExamButton()
                  : nextQuestionButton(
                      index: index,
                      answerText: controller.text,
                      questionType: 'OQ',
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Form codeCorrectionForm({
    required String questionText,
    required int maxPoint,
    required int index,
    required TextEditingController controller,
  }) {
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
            controller: controller,
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
            currentQuestion >= (exam.questions.length - 1)
                ? finishExamButton()
                : nextQuestionButton(
                    index: index,
                    answerText: controller.text,
                    questionType: 'CC',
                  ),
          ],
        ),
      ],
    ));
  }

  Form multipleChoiceForm(
      {required String questionText,
      required int maxPoint,
      required int index,
      required List<Answer> possibleAnswers}) {
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
          for (int i = 0; i < possibleAnswers.length; i++)
            checkboxAnswer(
                index: i, answerText: possibleAnswers[i].answerText!),
          const SizedBox(height: 16.0),
          Column(
            children: [
              currentQuestion >= (exam.questions.length - 1)
                  ? finishExamButton()
                  : nextQuestionButton(
                      index: index,
                      questionType: 'MC',
                      possibleAnswers: possibleAnswers,
                    ),
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

  // Store/update the answers of the student.
  void _updateAnswers(
    int index,
    String value,
    String questionType,
    List<Answer> possibleAnswers,
  ) {
    String? foundId;
    String id = "question_${index + 1}";

    // Check if the answer is already stored.
    for (var map in _answers) {
      if (map.containsKey("id")) {
        if (map["id"] == id) {
          foundId = id;
          break;
        }
      }
    }

    // Remove the answer if answer exists.
    if (foundId != null) {
      _answers.removeWhere((map) {
        return map["id"] == foundId;
      });
    }

    // Add the new answer.
    Map<String, dynamic> json;
    if (questionType == 'MC') {
      // Create a mapping of the answers of the student.
      List<Map<String, dynamic>> studentAnswers = [];
      for (int i = 0; i < possibleAnswers.length; i++) {
        Map<String, dynamic> answer = {
          'text': possibleAnswers[i].answerText,
          'answer': isChecked[i],
        };

        studentAnswers.add(answer);
      }
      json = {
        "id": id,
        "type": questionType,
        "student_answers": studentAnswers,
      };
    } else {
      json = {
        "id": id,
        "student_answer": value,
        "type": questionType,
      };
    }
    _answers.add(json);
  }

  ElevatedButton nextQuestionButton({
    int index = -1,
    String answerText = "idk",
    String questionType = "OQ",
    List<Answer> possibleAnswers = const [],
  }) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          // Store/update the answers of the student in a list.
          _updateAnswers(index, answerText, questionType, possibleAnswers);
          print('--PRINT ALL ANSWERS--');
          print(_answers);

          // Next question.
          currentQuestion++;

          // TODO: if already answered, show the answer in the text field from the answers list.
          setAnswer(currentQuestion);
          // // Clear the text field.
          // openQuestionController.text = "";
          // codeCorrectionController.text = "";
          // isChecked = [false, false, false];
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

  void setAnswer(int index) {
    String? foundId;
    String? foundType;
    String id = "question_${index + 1}";
    // Check if the answer is already stored.
    for (var map in _answers) {
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
      isChecked = [false, false, false];
      return;
    }

    print('get answer from $foundType');

    switch (foundType) {
      case 'OQ':
        Map<String, dynamic> getAnswer =
            _answers.where((element) => element["id"] == id).first;
        String answer = getAnswer["student_answer"];
        print(answer);
        openQuestionController.text = answer;
        break;
      case 'CC':
        Map<String, dynamic> getAnswer =
            _answers.where((element) => element["id"] == id).first;
        String answer = getAnswer["student_answer"];
        print(answer);
        openQuestionController.text = answer;
        break;
      case 'MC':
        // TODO: do this.
        print("IN MC");
        Map<String, dynamic> getAnswer =
            _answers.where((element) => element["id"] == id).first;
        List<Map<String, dynamic>> getStudentAnswersMultipleChoice =
            getAnswer["student_answers"];
        print(getStudentAnswersMultipleChoice);
        for (int i = 0; i < getStudentAnswersMultipleChoice.length; i++) {
          isChecked[i] = getStudentAnswersMultipleChoice[i]["answer"];
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
            currentQuestion = index;
            // TODO: if already answered, show the answer in the text field from the answers list.
            setAnswer(currentQuestion);
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    openQuestionController.dispose();
    codeCorrectionController.dispose();
    super.dispose();
  }
}
