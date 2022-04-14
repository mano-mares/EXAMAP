import 'package:flutter/material.dart';
import 'strings.dart' as strings;

class OpenQuestionForm extends StatefulWidget {
  const OpenQuestionForm({Key? key}) : super(key: key);

  @override
  State<OpenQuestionForm> createState() => _OpenQuestionFormState();
}

class _OpenQuestionFormState extends State<OpenQuestionForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: const [
          Text(
            strings.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50.0,
            ),
          ),
          Text(
            strings.description,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
