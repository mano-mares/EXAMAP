import 'package:examap/add_question/multiple_choice/answer_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/questions/multiple_choice/answer.dart';
import 'strings.dart' as strings;

class MultipleChoiceForm extends StatefulWidget {
  const MultipleChoiceForm({Key? key}) : super(key: key);

  @override
  State<MultipleChoiceForm> createState() => _MultipleChoiceFormState();
}

class _MultipleChoiceFormState extends State<MultipleChoiceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController, _pointController;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController();
    _pointController = TextEditingController();
  }

  void _addMultipleChoice() {
    if (_formKey.currentState!.validate()) {
      // TODO: implement this function.
    }
  }

  void _getAnswerA(Answer answer) {
    print('I got answer A ${answer.answerText} and ${answer.isCorrect}');
  }

  void _getAnswerB(Answer answer) {
    print('I got answer B ${answer.answerText} and ${answer.isCorrect}');
  }

  void _getAnswerC(Answer answer) {
    print('I got answer C ${answer.answerText} and ${answer.isCorrect}');
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
                    fontSize: 50.0,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  strings.description,
                  style: TextStyle(
                    fontSize: 20.0,
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
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    AnswerForm(
                      index: 'A',
                      answer: (Answer answer) => _getAnswerA(answer),
                      validator: () => _validateAnswer,
                    ),
                    AnswerForm(
                      index: 'B',
                      answer: (Answer answer) => _getAnswerB(answer),
                      validator: () => _validateAnswer,
                    ),
                    AnswerForm(
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
                  textStyle: const TextStyle(fontSize: 16.0),
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
