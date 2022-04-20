import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'strings.dart' as strings;

class CodeCorrectionForm extends StatefulWidget {
  const CodeCorrectionForm({Key? key}) : super(key: key);

  @override
  State<CodeCorrectionForm> createState() => _CodeCorrectionFormState();
}

class _CodeCorrectionFormState extends State<CodeCorrectionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final int _textAreaSize = 10;
  late TextEditingController _codeController,
      _correctCodeController,
      _pointController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
    _correctCodeController = TextEditingController();
    _pointController = TextEditingController();
  }

  String? _validateCode(value) {
    if (value == null || value.isEmpty) {
      return 'Code is vereist';
    }
    return null;
  }

  String? _validatePoints(points) {
    if (points == null || points.isEmpty) {
      return 'Punt is vereist';
    }
    return null;
  }

  void _addCodeCorrection() {
    // TODO: add code correction to exam.
    if (_formKey.currentState!.validate()) {
      print('add question');
    }
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
              const SizedBox(
                height: 16.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  strings.labelCode,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _codeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: _textAreaSize,
                  maxLines: _textAreaSize,
                  validator: _validateCode,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  strings.labelCorrecteCode,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _correctCodeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: _textAreaSize,
                  maxLines: _textAreaSize,
                  validator: _validateCode,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _pointController,
                  decoration: const InputDecoration(
                    labelText: strings.labelPoint,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: _validatePoints,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: _addCodeCorrection,
                  child: const Text(strings.buttonText),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                    textStyle: const TextStyle(fontSize: 16.0),
                    primary: Colors.redAccent[700],
                  ),
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
    _codeController.dispose();
    _correctCodeController.dispose();
    _pointController.dispose();
    super.dispose();
  }
}
