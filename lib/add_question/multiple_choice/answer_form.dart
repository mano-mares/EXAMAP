import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../models/questions/multiple_choice/answer.dart';

class AnswerForm extends StatefulWidget {
  final String index;
  final Function(Answer) answer;
  final Function validator;
  const AnswerForm({
    Key? key,
    required this.index,
    required this.answer,
    required this.validator,
  }) : super(key: key);

  @override
  State<AnswerForm> createState() => _AnswerFormState();
}

class _AnswerFormState extends State<AnswerForm> {
  String dropdownValue = 'Fout';
  final TextEditingController _answerController = TextEditingController();
  Answer data = Answer();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _answerController.addListener(_setAnswerText);
  }

  void _setValue(String? newValue) {
    setState(() {
      dropdownValue = newValue!;
    });

    data.isCorrect = (dropdownValue == 'Correct');
    widget.answer(data);
  }

  void _setAnswerText() {
    data.isCorrect = (dropdownValue == 'Correct');
    data.answerText = _answerController.text;
    widget.answer(data);
  }

  List<DropdownMenuItem<String>>? _options() {
    return <String>['Fout', 'Correct']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          child: Text(
            widget.index,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: TextFormField(
            controller: _answerController,
            decoration: const InputDecoration(
              labelText: 'Antwoord',
              border: OutlineInputBorder(),
            ),
            validator: widget.validator(),
          ),
        ),
        Flexible(
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            onChanged: _setValue,
            items: _options(),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }
}
