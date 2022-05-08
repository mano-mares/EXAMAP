import 'dart:ui';
import 'package:examap/student_list/add_student/add_student.dart';
import 'package:flutter/material.dart';

import './strings.dart' as strings;
import '../Student/choose_student_number/students.dart' as students;
import '../res/style/my_fontsize.dart' as sizes;

import 'package:firebase_core/firebase_core.dart';
import 'package:examap/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  TextEditingController studentController = TextEditingController();

  FirebaseFirestore? firestore;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  }

  @override
  void dispose() {
    studentController.dispose();
    super.dispose();
  }

  Future<void> getData(studentStore) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await studentStore.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.id).toList().join(", ");
    print(allData);

    studentController.text = allData.toString();
  }

  void _loadStudents() async {
    firestore = FirebaseFirestore.instance;

    if (firestore != null) {
      // TO DO
      // Reference the correct Exam
      CollectionReference studentStore = firestore!
          .collection("exam2")
          .doc("Python Development")
          .collection("students");

      await getData(studentStore);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 245, 241, 241),
      child: Column(children: [
        Padding(
            padding: const EdgeInsets.only(
                left: 128, right: 128, top: 128, bottom: 50),
            // Read only field...
            child: TextFormField(
              enabled: false,
              style: const TextStyle(fontSize: sizes.text),
              controller: studentController,
              restorationId: 'student_list_field',
              // focusNode: _lifeStory,
              decoration: const InputDecoration(
                  helperStyle: TextStyle(fontSize: sizes.xSmall),
                  border: OutlineInputBorder()),
              maxLines: 15,
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () => _loadStudents(),
                child: const Text(strings.loadStudent,
                    style: TextStyle(fontSize: sizes.btnSmall)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  fixedSize: const Size(165, 50),
                )),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentListAdd(),
                  ),
                );
              },
              child: const Text(strings.editStudentList,
                  style: TextStyle(fontSize: sizes.btnSmall)),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                fixedSize: const Size(155, 50),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
