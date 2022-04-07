import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/exam.dart';

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

  void _delete(BuildContext context) {
    context.read<Exam>().removeQuestion(index);
  }

  void _edit() {
    print('edit card $index');
  }

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
                onPressed: () {
                  _delete(context);
                },
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: _edit,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
