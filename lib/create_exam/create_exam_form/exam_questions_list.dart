import 'package:examap/add_question/code_correction/code_correction_form.dart';
import 'package:examap/create_exam/create_exam_form/question_card.dart';
import 'package:examap/models/questions/question_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../add_question/open_question/open_question_form.dart';
import '../../models/exam.dart';
import '../../models/questions/question.dart';
import '../strings.dart' as strings;

class ExamQuestionsList extends StatefulWidget {
  const ExamQuestionsList({Key? key}) : super(key: key);

  @override
  State<ExamQuestionsList> createState() => _ExamQuestionsListState();
}

class _ExamQuestionsListState extends State<ExamQuestionsList> {
  void _addQuestion(QuestionType questionType) {
    switch (questionType) {
      case QuestionType.open:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OpenQuestionForm()),
        );
        break;
      case QuestionType.multiple:
        // TODO: Go to add multiple choice form:
        break;
      case QuestionType.code:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CodeCorrectionForm()),
        );
        break;
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 245, 241, 241),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Center(
              child: Text(
                strings.headingText,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
              child: Consumer<Exam>(
                builder: (context, exam, child) {
                  return ListView.builder(
                    itemCount: exam.questions.length,
                    itemBuilder: (context, index) {
                      Question question = exam.questions[index];
                      return QuestionCard(
                          index: index,
                          id: question.id,
                          questionText: question.questionText,
                          questionType: question.questionType,
                          points: question.maxPoint);
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 32.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => _addQuestion(QuestionType.open),
                icon: const Icon(Icons.add),
                label: const Text(strings.openQuestion),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _addQuestion(QuestionType.multiple),
                icon: const Icon(Icons.add),
                label: const Text(strings.multipleChoice),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _addQuestion(QuestionType.code),
                icon: const Icon(Icons.add),
                label: const Text(strings.codeCorrection),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32.0,
          ),
        ],
      ),
    );
  }
}
