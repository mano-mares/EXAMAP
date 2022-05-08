import 'package:examap/create_exam/create_exam_form/exam_questions_list.dart';
import 'package:examap/models/exam.dart';
import 'package:examap/models/questions/code_correction/code_correction_question.dart';
import 'package:examap/models/questions/multiple_choice/multiple_choice_question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:examap/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../strings.dart' as strings;
import '../../res/style/my_fontsize.dart' as sizes;

class CreateExamForm extends StatefulWidget {
  const CreateExamForm({Key? key}) : super(key: key);

  @override
  State<CreateExamForm> createState() => _CreateExamFormState();
}

class _CreateExamFormState extends State<CreateExamForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TimeOfDay _initialTime = const TimeOfDay(hour: 1, minute: 30);

  late TextEditingController _nameController;
  late TextEditingController _timeController;

  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    loadFirestore();
    _nameController = TextEditingController();
    _timeController = TextEditingController(text: _parseTime(_initialTime));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void loadFirestore() async {
    firestore = FirebaseFirestore.instance;
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: _initialTime,
        initialEntryMode: TimePickerEntryMode.input,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    if (newTime != null) {
      setState(() {
        _timeController.text = _parseTime(newTime);
      });
    }
  }

  String _parseTime(TimeOfDay time) {
    return '${time.hour}:${time.minute} uur';
  }

  String? _validateName(name) {
    if (name == null || name.isEmpty) {
      return 'Naam is vereist';
    }
    return null;
  }

  void _createExam(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String subject = _nameController.text;
      String timeLimit = _timeController.text;

      Exam exam = context.read<Exam>();

      // Set exam properties.
      exam.subject = subject;
      exam.timeLimit = timeLimit;

      // Navigate back.
      Navigator.pop(context);

      // Show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(strings.snackbar),
          duration: Duration(milliseconds: 1500),
          behavior: SnackBarBehavior.floating,
        ),
      );

      final collectionExam = <String, dynamic>{
        "subject": _nameController.text.trim(),
        "time_limit": _timeController.text.trim(),
      };
      //make collection + doc
      firestore
          .collection("exam")
          .doc(_nameController.text.trim())
          .set(collectionExam);
      var questionPrint;
      var questionRef = firestore
          .collection("exam")
          .doc(_nameController.text.trim())
          .collection("questions");
      //loop through questions
      for (var i = 0; i < exam.questions.length; i++) {
        //doc
        questionPrint = "question_" + (i + 1).toString();
        //Multiple Choice
        if (exam.questions[i].questionType == strings.multipleChoice) {
          MultipleChoiceQuestion currentQuestion =
              exam.questions[i] as MultipleChoiceQuestion;
          var arrayAnswers = [];
          for (var y = 0; y < currentQuestion.possibleAnswers.length; y++) {
            var subAnswers = <String, dynamic>{
              "answer_text": currentQuestion.possibleAnswers[y].answerText,
              "is_correct": currentQuestion.possibleAnswers[y].isCorrect,
            };
            arrayAnswers.add(subAnswers);
            // firestore.collection("exam").doc(_nameController.text.trim()).collection("questions").doc(questionPrint).set(data)
          }
          var multipleChoice = <String, dynamic>{
            "max_point": currentQuestion.maxPoint,
            "question_text": currentQuestion.questionText,
            "question_type": "MC",
            "answers": arrayAnswers,
          };
          questionRef.doc(questionPrint).set(multipleChoice);
        }

        //Code Correction
        else if (exam.questions[i].questionType == strings.codeCorrection) {
          CodeCorrectionQuestion currentQuestion =
              exam.questions[i] as CodeCorrectionQuestion;
          var codeCorrection = <String, dynamic>{
            "answer_text": currentQuestion.answerText,
            "max_point": currentQuestion.maxPoint,
            "question_text": currentQuestion.questionText,
            "question_type": "CC"
          };
          questionRef.doc(questionPrint).set(codeCorrection);
        }

        //Open Question
        else {
          var openQuestion = <String, dynamic>{
            "max_point": exam.questions[i].maxPoint,
            "question_text": exam.questions[i].questionText,
            "question_type": "OQ"
          };
          questionRef.doc(questionPrint).set(openQuestion);
        }
      }
      // Clear questions list.
      exam.questions.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: strings.labelSubject,
              border: OutlineInputBorder(),
            ),
            validator: _validateName,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _timeController,
            decoration: const InputDecoration(
              labelText: strings.labelTimeLimit,
              border: OutlineInputBorder(),
            ),
            readOnly: true,
            onTap: _selectTime,
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
              child: ExamQuestionsList(),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: const Text(strings.createButtonText),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(24.0),
                    textStyle: const TextStyle(fontSize: sizes.btnXSmall),
                    primary: Colors.redAccent[700],
                  ),
                  onPressed: () => _createExam(context),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
