import 'package:flutter/material.dart';
import 'strings.dart' as strings;

class StudentLocation extends StatefulWidget {
  const StudentLocation({Key? key}) : super(key: key);

  @override
  State<StudentLocation> createState() => _StudentLocationState();
}

class _StudentLocationState extends State<StudentLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appBarTitle),
        centerTitle: true,
      ),
      body: Text('student location here!'),
    );
  }
}
