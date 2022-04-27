import 'package:flutter/material.dart';

class AnswerForm extends StatefulWidget {
  const AnswerForm({Key? key}) : super(key: key);

  @override
  State<AnswerForm> createState() => _AnswerFormState();
}

class _AnswerFormState extends State<AnswerForm> {
  String dropdownValue = 'Fout';

  void _setValue(String? newValue) {
    setState(() {
      dropdownValue = newValue!;
    });
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
        const Flexible(
          child: Text('A'),
        ),
        Expanded(
          flex: 5,
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: 'Antwoord',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Flexible(
          child: DropdownButton<String>(
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
}
