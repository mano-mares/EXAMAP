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
    return '${time.hour}:${time.minute} uur';
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

class QuestionCard extends StatelessWidget {
  const QuestionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Text('1'),
            title: Text('Leg het verschil uit tussen een stack en een heap.'),
            subtitle: Text(
              'Open vraag',
              style: TextStyle(fontFamily: 'cursive'),
            ),
            trailing: Text('2 ptn.'),
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
