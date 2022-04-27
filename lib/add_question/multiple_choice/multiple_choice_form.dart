import 'package:examap/add_question/multiple_choice/answer_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'strings.dart' as strings;

class MultipleChoiceForm extends StatefulWidget {
  const MultipleChoiceForm({Key? key}) : super(key: key);

  @override
  State<MultipleChoiceForm> createState() => _MultipleChoiceFormState();
}

class _MultipleChoiceFormState extends State<MultipleChoiceForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController, _pointController;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController();
    _pointController = TextEditingController();
  }

  void _addMultipleChoice() {
    // TODO: implement this function.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appBarTitle),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Center(
                child: Text(
                  strings.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0,
                  ),
                ),
              ),
              const Center(
                child: Text(
                  strings.description,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(
                  labelText: strings.labelQuestion,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _pointController,
                decoration: const InputDecoration(
                  labelText: strings.labelPoints,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
              const SizedBox(height: 16.0),
              Container(
                height: 400,
                color: const Color.fromARGB(255, 245, 241, 241),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Center(
                      child: Text(
                        strings.headingText,
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    AnswerForm(),
                    AnswerForm(),
                    AnswerForm(),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addMultipleChoice,
                child: const Text(strings.buttonText),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20.0),
                  textStyle: const TextStyle(fontSize: 16.0),
                  primary: Colors.redAccent[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _pointController.dispose();
    super.dispose();
  }
}
