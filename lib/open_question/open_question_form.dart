import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'strings.dart' as strings;

class OpenQuestionForm extends StatefulWidget {
  const OpenQuestionForm({Key? key}) : super(key: key);

  @override
  State<OpenQuestionForm> createState() => _OpenQuestionFormState();
}

class _OpenQuestionFormState extends State<OpenQuestionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late TextEditingController _scoreController;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController();
    _scoreController = TextEditingController();
  }

  void _addOpenQuestion() {
    if (_formKey.currentState!.validate()) {
      // TODO: add question to questions list in exam object.
      print(
          'question: ${_questionController.text}, points: ${_scoreController.text}');

      // TODO: go back to create exam form.
    }
  }

  String? _validateQuestion(question) {
    if (question == null || question.isEmpty) {
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            strings.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50.0,
            ),
          ),
          const Text(
            strings.description,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: strings.labelQuestion,
                border: OutlineInputBorder(),
              ),
              validator: _validateQuestion,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _scoreController,
              decoration: const InputDecoration(
                labelText: strings.labelPoints,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                // Only numbers can be entered.
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              validator: _validatePoints,
            ),
          ),
          ElevatedButton(
            onPressed: _addOpenQuestion,
            child: const Text(strings.buttonText),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20.0),
              textStyle: const TextStyle(fontSize: 16.0),
              primary: Colors.redAccent[700],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _scoreController.dispose();
    super.dispose();
  }
}
