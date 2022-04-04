import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final int index;
  final String questionText;
  final String questionType;
  final int points;

  const QuestionCard(
      {required this.index,
      required this.questionText,
      required this.questionType,
      required this.points,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Text(
              '$index.',
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
            title: Text(questionText),
            subtitle: Text(
              questionType,
              style: const TextStyle(fontFamily: 'cursive'),
            ),
            trailing: Text('$points ptn.'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => print('delete'),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => print('edit'),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
