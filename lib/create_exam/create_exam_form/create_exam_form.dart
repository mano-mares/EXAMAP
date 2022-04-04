import 'package:examap/create_exam/create_exam_form/exam_questions_list.dart';
import 'package:flutter/material.dart';

class CreateExamForm extends StatefulWidget {
  const CreateExamForm({Key? key}) : super(key: key);

  @override
  State<CreateExamForm> createState() => _CreateExamFormState();
}

class _CreateExamFormState extends State<CreateExamForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TimeOfDay _initialTime = const TimeOfDay(hour: 1, minute: 30);
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    _timeController = TextEditingController(text: _parseTime(_initialTime));
  }

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: _initialTime,
        initialEntryMode: TimePickerEntryMode.input,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        });
    if (newTime != null) {
      setState(() {
        _timeController.text = _parseTime(newTime);
      });
    }
  }

  String _parseTime(TimeOfDay time) {
    return '${time.hour}:${time.minute} uur';
  }

  void _createExam() {
    // TODO: create an exam object and go to admin home page
    print('Clicked! Create an exam object');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Vak',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          controller: _timeController,
          decoration: const InputDecoration(
            labelText: 'Duur',
            border: OutlineInputBorder(),
          ),
          readOnly: true,
          onTap: _selectTime,
        ),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
            child: ExamQuestionsList(),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                child: const Text('EXAMEN AANMAKEN'),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(24.0),
                    textStyle: const TextStyle(fontSize: 16.0)),
                onPressed: () => _createExam(),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
