import 'package:examap/create_exam/create_exam_form/create_exam_form.dart';
import 'package:examap/models/exam.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateExamPage extends StatefulWidget {
  const CreateExamPage({Key? key}) : super(key: key);

  @override
  State<CreateExamPage> createState() => _CreateExamPageState();
}

class _CreateExamPageState extends State<CreateExamPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Exam(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Examen maken'),
          centerTitle: true,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: CreateExamForm(),
        ),
      ),
    );
  }
}
