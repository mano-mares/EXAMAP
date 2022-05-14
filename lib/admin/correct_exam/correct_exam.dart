import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../firebase_options.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../../res/style/my_fontsize.dart' as sizes;

class CorrectExam extends StatefulWidget {
  const CorrectExam({Key? key, this.studentNumber}) : super(key: key);

  @override
  State<CorrectExam> createState() => _CorrectExamState();

  final studentNumber;
}

class _CorrectExamState extends State<CorrectExam> {
  late FirebaseFirestore firestore;
  var output;
  var preValue;
  var afterValue;
  var totalGrade = 0;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    loadFirestore();
    loadLeftExam();
  }

  void loadFirestore() {
    firestore = FirebaseFirestore.instance;
  }

  List questionsValues = [];
  List values = [];
  int valueIndex = 0;
  changeGrade(int changedValue, String inputPlace) {
    totalGrade = 0;
    if (questionsValues.contains(inputPlace)) {
      valueIndex = questionsValues.indexOf(inputPlace);
      values[valueIndex] = changedValue;
    } else {
      questionsValues.add(inputPlace);
      valueIndex = questionsValues.indexOf(inputPlace);
      values.add(changedValue);
    }
    for (int i = 0; i < values.length; i++) {
      totalGrade = values[i] + totalGrade;
    }
    setState(() {});
  }

  void saveCorrectedExam() {
    var grade = <String, dynamic>{
      "exam_result": totalGrade,
      "exam_is_corrected": true
    };
    firestore
        .collection("EXAMAP")
        .doc("exam")
        .collection("students")
        .doc(widget.studentNumber)
        .update(grade);
    Navigator.pop(context);
  }

  void loadLeftExam() async {
    var querySnapshot = await firestore
        .collection('EXAMAP')
        .doc('exam')
        .collection('students')
        .doc(widget.studentNumber)
        .get()
        .then((value) {
      Map data = value.data() as Map;
      output = (data['times_left_exam']);
    });
    setState(() {});
  }

  void changeGradeQuestion() {}
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
                          height: 350,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: firestore
                                .collection('EXAMAP')
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
                                        title: doc.get("question_type") == "OQ"
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 15, 0, 15),
                                                child: Column(
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
                                                      'Antwoord student: ${doc.get("student_answer")}',
                                                      style: const TextStyle(
                                                          fontSize:
                                                              sizes.small),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : doc.get("question_type") == "CC"
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 15, 0, 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Gegeven: ${doc.get("question_text")}',
                                                          style: const TextStyle(
                                                              fontSize:
                                                                  sizes.small),
                                                        ),
                                                        Text(
                                                          'Oplossing: ${doc.get("teacher_answer")}',
                                                          style: const TextStyle(
                                                              fontSize:
                                                                  sizes.small),
                                                        ),
                                                        Text(
                                                          'Antwoord student: ${doc.get("student_answer")}',
                                                          style: const TextStyle(
                                                              fontSize:
                                                                  sizes.small),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${doc.get("question_text")}',
                                                        style: const TextStyle(
                                                            fontSize:
                                                                sizes.small),
                                                      ),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              doc.get("student_answers")[
                                                                      0][
                                                                  "answer_text"],
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: sizes
                                                                      .small),
                                                            ),
                                                            doc.get("student_answers")[
                                                                        0][
                                                                    "student_answer"]
                                                                ? const Text(
                                                                    "Student: Juist",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            sizes
                                                                                .small))
                                                                : const Text(
                                                                    "Student: Fout",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            sizes.small)),
                                                            doc.get("teacher_answers")[
                                                                        0][
                                                                    "teacher_answer"]
                                                                ? const Text(
                                                                    "Correct antwoord: Juist",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            sizes
                                                                                .small))
                                                                : const Text(
                                                                    "Correct antwoord: Fout",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            sizes.small)),
                                                          ]),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              doc.get("student_answers")[
                                                                      1][
                                                                  "answer_text"],
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: sizes
                                                                      .small),
                                                            ),
                                                            doc.get("student_answers")[
                                                                        1][
                                                                    "student_answer"]
                                                                ? const Text(
                                                                    "Student: Juist",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            sizes
                                                                                .small))
                                                                : const Text(
                                                                    "Student: Fout",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            sizes.small)),
                                                            doc.get("teacher_answers")[
                                                                        1][
                                                                    "teacher_answer"]
                                                                ? const Text(
                                                                    "Correct antwoord: Juist",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            sizes
                                                                                .small))
                                                                : const Text(
                                                                    "Correct antwoord: Fout",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            sizes.small)),
                                                          ]),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              doc.get("student_answers")[
                                                                      2][
                                                                  "answer_text"],
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: sizes
                                                                      .small),
                                                            ),
                                                            doc.get("student_answers")[
                                                                        2][
                                                                    "student_answer"]
                                                                ? const Text(
                                                                    "Student: Juist",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            sizes
                                                                                .small))
                                                                : const Text(
                                                                    "Student: Fout",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            sizes.small)),
                                                            doc.get("teacher_answers")[
                                                                        2][
                                                                    "teacher_answer"]
                                                                ? const Text(
                                                                    "Correct antwoord: Juist",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            sizes
                                                                                .small))
                                                                : const Text(
                                                                    "Correct antwoord: Fout",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            sizes.small)),
                                                          ]),
                                                    ],
                                                  ),
                                        trailing: SizedBox(
                                          width: 150,
                                          child: Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 150,
                                                  child: SpinBox(
                                                    min: 0,
                                                    max: doc
                                                        .get("max_point")
                                                        .toDouble(),
                                                    value: 0,
                                                    readOnly: true,
                                                    onChanged: (value) =>
                                                        changeGrade(
                                                      value.toInt(),
                                                      doc.id,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
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
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Text(
                        "Resultaat: ${totalGrade}",
                        style: const TextStyle(fontSize: sizes.subTitle),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'Opmerking',
                style: TextStyle(color: Colors.red, fontSize: 30),
              ),
              Text(
                'Student ${widget.studentNumber} heeft ${output.toString()} keer het examen verlaten',
                style:
                    const TextStyle(fontSize: sizes.small, color: Colors.red),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        // TODO: navigate to location
                        onPressed: () => {},
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Locatie",
                            style: TextStyle(fontSize: sizes.btnMedium),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: saveCorrectedExam,
                        child: const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Opslaan",
                            style: TextStyle(fontSize: sizes.btnMedium),
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
