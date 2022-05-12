import 'package:examap/student/choose_student_number/students.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';
import 'package:flutter_spinbox/material.dart';

import '../res/style/my_fontsize.dart' as sizes;

class CorrectExam extends StatefulWidget {
  const CorrectExam({Key? key, this.studentNumber}) : super(key: key);

  @override
  State<CorrectExam> createState() => _CorrectExamState();

  final studentNumber;
}

class _CorrectExamState extends State<CorrectExam> {
  late FirebaseFirestore firestore;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    loadFirestore();
  }

  void loadFirestore() {
    firestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Correct exam',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Student'),
        ),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "Examen verbeteren",
                  style: TextStyle(fontSize: sizes.title),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Text(
                  widget.studentNumber,
                  style: const TextStyle(fontSize: sizes.subTitle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.fromLTRB(80, 20, 0, 0),
                            child: Text(
                              "Vragen",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: sizes.medium,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(""),
                          Text("")
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 30, 80, 30),
                        child: SizedBox(
                          height: 200,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: firestore
                                // TODO: Change to EXAMAP
                                .collection('dummy_data_examap')
                                .doc('exam')
                                .collection('students')
                                .doc(widget.studentNumber)
                                .collection('answers')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              } else {
                                return ListView(
                                  children: snapshot.data!.docs.map((doc) {
                                    return Card(
                                        child: ListTile(
                                      title: Transform.translate(
                                          offset: const Offset(0, 0),
                                          child: doc.get("type") == "OQ"
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      doc.get(
                                                        "question_text",
                                                      ),
                                                      style: const TextStyle(
                                                          fontSize:
                                                              sizes.small),
                                                    ),
                                                    Text(
                                                        'Antwoord student: ${doc.get("student_answer")}'),
                                                  ],
                                                )
                                              : doc.get("type") == "CC"
                                                  ? Text("dsqfq")
                                                  : Column(
                                                      children: [
                                                        Text("MC"),
                                                      ],
                                                    )),
                                      trailing: SizedBox(
                                        width: 150,
                                        child: Padding(
                                          padding: EdgeInsets.all(0),
                                          child: SpinBox(
                                            min: 0,
                                            max:
                                                doc.get("max_point").toDouble(),
                                            value: 0,
                                          ),
                                        ),
                                      ),
                                    ));
                                  }).toList(),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
