import 'package:flutter/material.dart';
import 'strings.dart' as strings;

class CodeCorrectionForm extends StatefulWidget {
  const CodeCorrectionForm({Key? key}) : super(key: key);

  @override
  State<CodeCorrectionForm> createState() => _CodeCorrectionFormState();
}

class _CodeCorrectionFormState extends State<CodeCorrectionForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appBarTitle),
        centerTitle: true,
      ),
    );
  }
}
