import 'package:examap/admin/add_question/multiple_choice/multiple_choice_answer_form.dart';
import 'package:examap/models/questions/multiple_choice/multiple_choice_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../models/exam.dart';
import '../../../models/questions/multiple_choice/answer.dart';
import 'strings.dart' as strings;
import '../../../res/style/my_fontsize.dart' as sizes;

class MultipleChoiceForm extends StatefulWidget {
  const MultipleChoiceForm({Key? key}) : super(key: key);

  @override
  State<MultipleChoiceForm> createState() => _MultipleChoiceFormState();
}

class _MultipleChoiceFormState extends State<MultipleChoiceForm> {
  final uuid = const Uuid();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController, _pointController;
  Answer? answerA, answerB, answerC;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController();
    _pointController = TextEditingController();
  }

  void _addMultipleChoice() {
    if (_formKey.currentState!.validate()) {
      String questionText = _questionController.text;
      int maxPoint = int.parse(_pointController.text);
      List<Answer> answers = [answerA!, answerB!, answerC!];

      MultipleChoiceQuestion question = MultipleChoiceQuestion(
        id: uuid.v4(),
        questionText: questionText,
        maxPoint: maxPoint,
        questionType: 'Meerkeuze',
        possibleAnswers: answers,
      );

      // Add question to exam
      context.read<Exam>().addQuestion(question);

      // Go back to create exam page.
      Navigator.pop(context);

      // Show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(strings.snackBar),
          duration: Duration(milliseconds: 1500),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _getAnswerA(Answer answer) {
    answerA = answer;
  }

  void _getAnswerB(Answer answer) {
    answerB = answer;
  }

  void _getAnswerC(Answer answer) {
    answerC = answer;
  }

  String? _validateQuestionText(questionText) {
    if (questionText == null || questionText.isEmpty) {
      return 'Vraag is vereist';
    }
    return null;
  }

  String? _validatePoints(points) {
    if (points == null || points.isEmpty) {
      return 'Punt is vereist';
    }
    return null;
  }

  String? _validateAnswer(answer) {
    if (answer == null || answer.isEmpty) {
      return 'Antwoord is vereist';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appBarTitle),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Center(
                child: Text(
                  strings.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: sizes.title,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  strings.description,
                  style: TextStyle(
                    fontSize: sizes.text,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(
                  labelText: strings.labelQuestion,
                  border: OutlineInputBorder(),
                ),
                validator: _validateQuestionText,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _pointController,
                decoration: const InputDecoration(
                  labelText: strings.labelPoints,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                validator: _validatePoints,
              ),
              const SizedBox(height: 16.0),
              Container(
                height: 400,
                color: const Color.fromARGB(255, 245, 241, 241),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Center(
                      child: Text(
                        strings.headingText,
                        style: TextStyle(
                            fontSize: sizes.headingText,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    MultipleChoiceAnswerForm(
                      index: 'A',
                      answer: (Answer answer) => _getAnswerA(answer),
                      validator: () => _validateAnswer,
                    ),
                    MultipleChoiceAnswerForm(
                      index: 'B',
                      answer: (Answer answer) => _getAnswerB(answer),
                      validator: () => _validateAnswer,
                    ),
                    MultipleChoiceAnswerForm(
                      index: 'C',
                      answer: (Answer answer) => _getAnswerC(answer),
                      validator: () => _validateAnswer,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addMultipleChoice,
                child: const Text(strings.buttonText),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20.0),
                  textStyle: const TextStyle(fontSize: sizes.btnXSmall),
                  primary: Colors.redAccent[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _pointController.dispose();
    super.dispose();
  }
}
