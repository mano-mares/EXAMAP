import 'package:examap/create_exam/create_exam_form/question_card.dart';
import 'package:flutter/material.dart';

enum QuestionType {
  open,
  multiple,
  code,
}

class ExamQuestionsList extends StatefulWidget {
  const ExamQuestionsList({Key? key}) : super(key: key);

  @override
  State<ExamQuestionsList> createState() => _ExamQuestionsListState();
}

class _ExamQuestionsListState extends State<ExamQuestionsList> {
  final List<Widget> questions = [
    const QuestionCard(),
    const QuestionCard(),
    const QuestionCard(),
    const QuestionCard(),
    const QuestionCard(),
    const QuestionCard(),
    const QuestionCard(),
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 213, 211, 211),
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
              child: ListView(
                children: questions,
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
                  label: const Text('Open vraag')),
              ElevatedButton.icon(
                  onPressed: () => _addQuestion(QuestionType.multiple),
                  icon: const Icon(Icons.add),
                  label: const Text('Meerkeuze')),
              ElevatedButton.icon(
                  onPressed: () => _addQuestion(QuestionType.code),
                  icon: const Icon(Icons.add),
                  label: const Text('Code correctie')),
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
