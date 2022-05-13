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

import 'package:firebase_core/firebase_core.dart';
import 'package:examap/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'strings.dart' as strings;

enum QuestionType { OQ, CC, MC }

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

  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    setState(() {
      // Assign 0 to _currentQuestion if _currentQuestion is null.
      _currentQuestionIndex ??= 0;

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

  Future<void> loadFirestore() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    firestore = FirebaseFirestore.instance;
  }

  // Get the exam questions from firestore.
  Future<Exam> getExam() async {
    await loadFirestore();
    final DocumentReference documentReference = firestore
        .collection(strings.headCollection)
        .doc(strings.headCollectionDoc);
    final CollectionReference collectionReference =
        documentReference.collection(strings.questionCollection);

    // Get the content of the exam document.
    final DocumentSnapshot documentSnapshot = await documentReference.get();

    // Create exam object
    Exam exam = Exam();

    // Load the exam
    exam.subject = documentSnapshot['subject'];
    exam.timeLimit = documentSnapshot['time_limit'];

    // Get all docs from the collection questions
    QuerySnapshot result = await collectionReference.get();

    // Get data from question docs and convert map to List
    final questions = result.docs.map(((doc) {
      var question = doc.data() as Map;
      question['id'] = doc.id; // Add document id
      return question;
    })).toList();

    // Add the question to the exam.
    for (var question in questions) {
      QuestionType currentQuestionType =
          convertToQuestionType(question[strings.questionType]);

      // Get the fields of the current question doc.
      final id = question[strings.id];
      final questionText = question[strings.questionText];
      final maxPoint = question[strings.maxPoint];
      final questionType = question[strings.questionType];

      switch (currentQuestionType) {
        case QuestionType.OQ:
          exam.addQuestion(
            OpenQuestion(
              id: id,
              questionText: questionText,
              maxPoint: maxPoint,
              questionType: questionType,
            ),
          );
          break;
        case QuestionType.CC:
          exam.addQuestion(
            CodeCorrectionQuestion(
              id: id,
              questionText: questionText,
              maxPoint: maxPoint,
              questionType: questionType,
              answerText: question[strings.answerText],
            ),
          );
          break;
        case QuestionType.MC:
          List<dynamic> answers = question[strings.answers];
          List<Answer> possibleAnswers = [];
          for (var answer in answers) {
            possibleAnswers.add(
              Answer(
                answerText: answer[strings.answerText],
                isCorrect: answer[strings.isCorrect],
              ),
            );
          }
          exam.addQuestion(
            MultipleChoiceQuestion(
              id: id,
              questionText: questionText,
              maxPoint: maxPoint,
              questionType: questionType,
              possibleAnswers: possibleAnswers,
            ),
          );
          break;
        default:
          break;
      }
    }
    return exam;
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
          goToSubmitExamPage();
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

  // Based on the question type, show the appropriate form.
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_currentQuestionIndex! + 1}. ${_currentQuestion!.questionText}',
                  style: const TextStyle(
                    fontSize: sizes.medium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Open vraag (${_currentQuestion!.maxPoint} ptn.)',
                  style: const TextStyle(
                    fontSize: sizes.small,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_currentQuestionIndex! + 1}. Pas de code aan zodat dit zou werken.',
                style: const TextStyle(
                  fontSize: sizes.medium,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Code correctie (${_currentQuestion!.maxPoint} ptn.)',
                style: const TextStyle(
                  fontSize: sizes.small,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              const Text(
                'Gegeven',
                style: TextStyle(
                  fontSize: sizes.medium,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                _currentQuestion!.questionText,
                style: const TextStyle(
                  fontSize: sizes.small,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_currentQuestionIndex! + 1}. ${currentQuestion.questionText}',
                  style: const TextStyle(
                    fontSize: sizes.medium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Meerkeuze (${currentQuestion.maxPoint} ptn.)',
                  style: const TextStyle(
                    fontSize: sizes.small,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
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
    for (var map in _answers!) {
      if (map.containsKey("id")) {
        if (map["id"] == id) {
          foundId = id;
          break;
        }
      }
    }

    if (foundId != null) {
      _answers!.removeWhere((map) {
        return map["id"] == foundId;
      });
    }

    // 2.2 If not, append the answer to the list.
    Map<String, dynamic> json = {};

    // Do this or else everything breaks (idk why)
    QuestionType currentQuestionType =
        convertToQuestionType(_currentQuestion!.questionType);

    switch (currentQuestionType) {
      case QuestionType.OQ:
        OpenQuestion currentQuestion = _currentQuestion as OpenQuestion;
        json = {
          'id': id,
          'max_point': currentQuestion.maxPoint,
          'question_text': currentQuestion.questionText,
          'student_answer': openQuestionController.text,
          'question_type': QuestionType.OQ.name,
        };
        break;
      case QuestionType.CC:
        CodeCorrectionQuestion currentQuestion =
            _currentQuestion as CodeCorrectionQuestion;
        json = {
          'id': id,
          'max_point': currentQuestion.maxPoint,
          'question_text': currentQuestion.questionText,
          'student_answer': codeCorrectionController.text,
          'teacher_answer': currentQuestion.answerText,
          'question_type': QuestionType.CC.name,
        };
        break;
      case QuestionType.MC:
        MultipleChoiceQuestion currentQuestion =
            _currentQuestion as MultipleChoiceQuestion;
        // Create a mapping of the answers of the student.
        List<Map<String, dynamic>> studentAnswers = [];
        List<Map<String, dynamic>> teacherAnswers = [];
        for (int i = 0; i < currentQuestion.possibleAnswers.length; i++) {
          Map<String, dynamic> studentAnswer = {
            'answer_text': currentQuestion.possibleAnswers[i].answerText,
            'student_answer': _isChecked![i],
          };

          Map<String, dynamic> teacherAnswer = {
            'answer_text': currentQuestion.possibleAnswers[i].answerText,
            'teacher_answer': currentQuestion.possibleAnswers[i].isCorrect,
          };

          studentAnswers.add(studentAnswer);
          teacherAnswers.add(teacherAnswer);
        }
        json = {
          'id': id,
          'max_point': currentQuestion.maxPoint,
          'question_text': currentQuestion.questionText,
          'question_type': QuestionType.MC.name,
          'student_answers': studentAnswers,
          'teacher_answers': teacherAnswers,
        };
        break;
      default:
        break;
    }

    setState(() {
      _answers!.add(json);
    });
  }

  QuestionType convertToQuestionType(String type) {
    switch (type) {
      case 'OQ':
        return QuestionType.OQ;
      case 'CC':
        return QuestionType.CC;
      case 'MC':
        return QuestionType.MC;
      default:
        return QuestionType.OQ;
    }
  }

  void setAnswers() {
    String? foundId;
    String? foundType;
    final id = "question_${_currentQuestionIndex! + 1}";
    // Check if the answer is already stored.
    for (var map in _answers!) {
      if (map.containsKey("id")) {
        if (map["id"] == id) {
          // Check if the answer is empty
          foundId = id;
          foundType = map["type"];
          break;
        }
      }
    }

    // Exit if not already answered.
    if (foundId == null) {
      setState(() {
        // Clear the text field.
        openQuestionController.text = "";
        codeCorrectionController.text = "";
        _isChecked = [false, false, false];
      });
      return;
    }

    // Do this or everything breaks, thanks enum.
    QuestionType currentQuestionType = convertToQuestionType(foundType!);

    // If student already answered the question, show answer in the form.
    Map<String, dynamic> getAnswer =
        _answers!.where((element) => element["id"] == id).first;
    switch (currentQuestionType) {
      case QuestionType.OQ:
        setState(() {
          openQuestionController.text = getAnswer["student_answer"];
        });
        break;
      case QuestionType.CC:
        setState(() {
          codeCorrectionController.text = getAnswer["student_answer"];
        });
        break;
      case QuestionType.MC:
        List<Map<String, dynamic>> getStudentAnswersMultipleChoice =
            getAnswer["student_answers"];
        setState(() {
          for (int i = 0; i < getStudentAnswersMultipleChoice.length; i++) {
            _isChecked![i] =
                getStudentAnswersMultipleChoice[i]["student_answer"];
          }
        });
        break;
      default:
    }
  }

  ElevatedButton nextQuestionButton() {
    return ElevatedButton(
      onPressed: () {
        // Store/update the answers in the list.
        updateAnswers();

        // Go to the next question.
        setState(() {
          _currentQuestionIndex = _currentQuestionIndex! + 1;
        });

        // On the new question, see if the field is already filled in.
        setAnswers();
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
        // Store answers
        updateAnswers();

        // Go to the next question.
        setState(() {
          _currentQuestionIndex = index;
        });

        // On the new question, see if the field is already filled in.
        setAnswers();
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
          onPressed: () {
            // Store answers
            updateAnswers();
            showEndExamDialog();
          },
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
              goToSubmitExamPage();
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

  void goToSubmitExamPage() {
    // Push new page and remove all previous pages
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => SubmitExamPage(
            exam: _exam!,
            answers: _answers!,
          ),
        ),
        ((route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Exam>(
      // Future that needs to be resolved
      // inorder to display something on the Canvas
      future: getExam(), // a previously-obtained Future<Exam> or null
      builder: (BuildContext context, AsyncSnapshot<Exam> snapshot) {
        Widget examPage;
        if (snapshot.hasData) {
          // Extracting data from snapshot object
          _exam = snapshot.data as Exam;
          _questions ??= _exam?.questions;
          int? counterInSeconds = getStartTimeInSeconds(_exam!.timeLimit);
          _counterInSeconds ??=
              counterInSeconds; // Start value of the timer of the exam.
          _currentQuestion ??=
              _questions![_currentQuestionIndex!]; // set the current question.
          examPage = Scaffold(
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
        } else if (snapshot.hasError) {
          examPage = Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          // Displaying Loading Spinner to indicate waiting state
          examPage = Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return examPage;
      },
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
