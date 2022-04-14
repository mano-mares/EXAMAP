import 'package:flutter/material.dart';
import 'strings.dart' as strings;

class OpenQuestionForm extends StatefulWidget {
  const OpenQuestionForm({Key? key}) : super(key: key);

  @override
  State<OpenQuestionForm> createState() => _OpenQuestionFormState();
}

class _OpenQuestionFormState extends State<OpenQuestionForm> {
  late TextEditingController _questionController;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController();
  }

  void _addOpenQuestion() {
    // TODO: add question to questions list in exam object.

    // TODO: go back to create exam form.
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
            ),
          ),
          ElevatedButton(
            onPressed: _addOpenQuestion,
            child: const Text(strings.buttonText),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20.0),
              textStyle: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }
}
