import 'dart:ui';
import 'package:flutter/material.dart';

import '../strings.dart' as strings;
import '../../Student/choose_student_number/students.dart' as students;
import '../../res/style/my_fontsize.dart' as sizes;

class StudentListAdd extends StatefulWidget {
  const StudentListAdd({Key? key}) : super(key: key);

  @override
  State<StudentListAdd> createState() => _StudentListState();
}

class _StudentListState extends State<StudentListAdd> {
  TextEditingController studentController = TextEditingController();

  void _addStudent() {
    students.studentList = [];
    List<String> rawStudList = studentController.text.split(",");

    for (var student in rawStudList) {
      students.studentList.add(student.trim());
      // print(student.trim());
    }
    print(students.studentList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 245, 241, 241),
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.only(
                left: 128, right: 128, top: 128, bottom: 50),
            child: TextFormField(
              style: const TextStyle(fontSize: sizes.text),
              controller: studentController,
              restorationId: 'student_list_field',
              // focusNode: _lifeStory,
              decoration: const InputDecoration(
                helperStyle: TextStyle(fontSize: sizes.xSmall),
                border: OutlineInputBorder(),
                hintText: strings.hintText,
                helperText: strings.helperText,
                labelText: strings.hintText,
              ),
              maxLines: 15,
            )),
        ElevatedButton(
          onPressed: () => _addStudent(),
          child: const Text(strings.addStudent,
              style: TextStyle(fontSize: sizes.btnSmall)),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            fixedSize: const Size(150, 50),
          ),
        ),
      ]),
    );
  }
}
