import 'package:flutter/material.dart';
import 'strings.dart' as strings;

class CodeCorrectionForm extends StatefulWidget {
  const CodeCorrectionForm({Key? key}) : super(key: key);

  @override
  State<CodeCorrectionForm> createState() => _CodeCorrectionFormState();
}

class _CodeCorrectionFormState extends State<CodeCorrectionForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          child: Center(
            child: Column(children: [
              const Text(
                strings.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                ),
              ),
              const Text(
                strings.description,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
