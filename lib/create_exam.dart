import 'package:flutter/material.dart';

class CreateExamPage extends StatefulWidget {
  const CreateExamPage({Key? key}) : super(key: key);

  @override
  State<CreateExamPage> createState() => _CreateExamPageState();
}

class _CreateExamPageState extends State<CreateExamPage> {
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
    return '${time.hour}:${time.minute}';
  }

  void _createExam() {
    // TODO: create an exam object and go to admin home page
    print('Clicked! Create an exam object');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Examen maken'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
        ),
      ),
    );
  }
}

class ExamQuestionsList extends StatefulWidget {
  const ExamQuestionsList({Key? key}) : super(key: key);

  @override
  State<ExamQuestionsList> createState() => _ExamQuestionsListState();
}

class _ExamQuestionsListState extends State<ExamQuestionsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
    );
  }
}
