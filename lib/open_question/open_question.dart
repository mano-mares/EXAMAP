import 'package:flutter/material.dart';

import 'open_question_form.dart';
import 'strings.dart' as strings;

class OpenQuestionPage extends StatelessWidget {
  const OpenQuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appBarTitle),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: OpenQuestionForm(),
        ),
      ),
    );
  }
}
