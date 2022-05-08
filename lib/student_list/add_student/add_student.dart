import 'dart:ui';
import 'package:flutter/material.dart';

import '../strings.dart' as strings;
import '../../Student/choose_student_number/students.dart' as students;
import '../../res/style/my_fontsize.dart' as sizes;

import 'package:firebase_core/firebase_core.dart';
import 'package:examap/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentListAdd extends StatefulWidget {
  const StudentListAdd({Key? key}) : super(key: key);

  @override
  State<StudentListAdd> createState() => _StudentListAddState();
}

class _StudentListAddState extends State<StudentListAdd> {
  TextEditingController studentController = TextEditingController();

  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    loadFirestore();
  }

  @override
  void dispose() {
    studentController.dispose();
    super.dispose();
  }

  Future<String> getData() async {
    // Get docs from collection reference
    // TO DO
    // Reference the correct Exam
    QuerySnapshot querySnapshot = await firestore
        .collection(strings.headCollection)
        .doc(strings.headCollectionDoc)
        .collection(strings.studentCollection)
        .get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.id).toList().join(", ");
    print(allData);

    return allData.toString();
  }

  void loadFirestore() async {
    firestore = FirebaseFirestore.instance;
    studentController.text = await getData();
  }

  void _addStudent() async {
    students.studentList = [];
    String studentStore = await getData();
    // Student object
    final studentObject = <String, dynamic>{
      "exam_completed": false,
      "exam_result": null,
      "location": null
    };

    List<String> rawStudList = studentController.text.split(",");

    for (var student in rawStudList) {
      students.studentList.add(student.trim());
      if (!studentStore.contains(student)) {
        firestore
            .collection(strings.headCollection)
            .doc(strings.headCollectionDoc)
            .collection(strings.studentCollection)
            .doc(student)
            .set(studentObject, SetOptions(merge: true));
      }
    }
  }

  void _deleteStudent() async {
    students.studentList = [];
    String studentStore = await getData();

    List<String> rawStudList = studentController.text.split(",");

    for (var student in rawStudList) {
      students.studentList.add(student.trim());
      if (studentStore.contains(student)) {
        firestore
            .collection(strings.headCollection)
            .doc(strings.headCollectionDoc)
            .collection(strings.studentCollection)
            .doc(student)
            .delete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Students"),
        centerTitle: true,
      ),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.only(
                left: 128, right: 128, top: 128, bottom: 50),
            child: TextFormField(
              style: const TextStyle(fontSize: sizes.text),
              controller: studentController,
              restorationId: 'student_list_field',
              decoration: const InputDecoration(
                helperStyle: TextStyle(fontSize: sizes.xSmall),
                border: OutlineInputBorder(),
                hintText: strings.hintText,
                helperText: strings.helperText,
                labelText: strings.hintText,
              ),
              maxLines: 15,
            )),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            onPressed: () => _addStudent(),
            child: const Text(strings.addStudent,
                style: TextStyle(fontSize: sizes.btnSmall)),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              fixedSize: const Size(155, 50),
            ),
          ),
          ElevatedButton(
            onPressed: () => _deleteStudent(),
            child: const Text(strings.deleteStudent,
                style: TextStyle(fontSize: sizes.btnSmall)),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              fixedSize: const Size(180, 50),
            ),
          ),
        ])
      ]),
    );
  }
}
