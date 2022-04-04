import 'package:examap/create_exam/create_exam_form/question_card.dart';
import 'package:examap/create_exam/questionType.dart';
import 'package:flutter/material.dart';
import '../constant.dart' as constant;

class ExamQuestionsList extends StatefulWidget {
  const ExamQuestionsList({Key? key}) : super(key: key);

  @override
  State<ExamQuestionsList> createState() => _ExamQuestionsListState();
}

class _ExamQuestionsListState extends State<ExamQuestionsList> {
  List<Widget> questions = [
    const QuestionCard(
        index: 1,
        questionText: 'Leg het verschil uit tussen een stack en een heap.',
        questionType: constant.openQuestion,
        points: 3),
    const QuestionCard(
        index: 2,
        questionText: 'Welk datatype is 5.699?',
        questionType: constant.multipleChoice,
        points: 2),
    const QuestionCard(
        index: 3,
        questionText: 'Herschrijf de opgegeven code tot dat het werkt.',
        questionType: constant.codeCorrection,
        points: 2),
    const QuestionCard(
        index: 4,
        questionText: 'Leg het verchil uit tussen een float en een double.',
        questionType: constant.openQuestion,
        points: 3),
    const QuestionCard(
        index: 5,
        questionText: 'Wat is geen programeertaal uit de volgende opties?',
        questionType: constant.multipleChoice,
        points: 1),
    const QuestionCard(
        index: 6,
        questionText: 'Herschrijf de opgegeven code tot dat het werkt.',
        questionType: constant.codeCorrection,
        points: 2),
  ];

  void _addQuestion(QuestionType questionType) {
    switch (questionType) {
      case QuestionType.open:
        // TODO: Handler this case.
        print('TODO: Go to add open question form');
        break;
      case QuestionType.multiple:
        // TODO: Handle this case.
        print('TODO: Go to add multiple choice form');
        break;
      case QuestionType.code:
        // TODO: Handle this case.
        print('TODO: Go to add code correction form');
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
                'Vragen',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 0.0),
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return questions[index];
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
                  label: const Text(constant.openQuestion)),
              ElevatedButton.icon(
                  onPressed: () => _addQuestion(QuestionType.multiple),
                  icon: const Icon(Icons.add),
                  label: const Text(constant.multipleChoice)),
              ElevatedButton.icon(
                  onPressed: () => _addQuestion(QuestionType.code),
                  icon: const Icon(Icons.add),
                  label: const Text(constant.codeCorrection)),
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
