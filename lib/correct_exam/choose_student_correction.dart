import 'package:examap/correct_exam/correct_exam.dart';
import 'package:flutter/material.dart';
import '../res/style/my_fontsize.dart' as sizes;
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChooseStudentCorrection extends StatefulWidget {
  const ChooseStudentCorrection({Key? key}) : super(key: key);

  @override
  State<ChooseStudentCorrection> createState() => _ChooseStudentCorrection();
}

class _ChooseStudentCorrection extends State<ChooseStudentCorrection> {
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

  void chooseStudent() {
    print("Choose student");
  }

  void navigateToStudentCorrection(var inputStudentNumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CorrectExam(
          studentNumber: inputStudentNumber,
        ),
      ),
    );
  }

  final items = List.generate(70, (counter) => 'Item: $counter');
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
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "Examen verbeteren",
                style: TextStyle(
                  fontSize: sizes.large,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Text(
                "Studenten",
                style: TextStyle(
                  fontSize: sizes.medium,
                ),
              ),
            ),
            const Text(
              "Kies een student waarvan je het examen wenst te verbeteren",
              style: TextStyle(
                fontSize: sizes.small,
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
                            "Verbeterd",
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
                              .collection('EXAMAP')
                              .doc('exam')
                              .collection('students')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            } else {
                              return ListView(
                                children: snapshot.data!.docs.map((doc) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(doc.id),
                                      trailing:
                                          const Icon(Icons.arrow_forward_ios),
                                      onTap: () =>
                                          navigateToStudentCorrection(doc.id),
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
                            "Niet verbeterd",
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
                              .collection('EXAMAP')
                              .doc('exam')
                              .collection('students')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            } else {
                              return ListView(
                                children: snapshot.data!.docs.map((doc) {
                                  return Card(
                                    child: ListTile(
                                        title: Text(
                                            "${doc.id}     ${doc.get("exam_result")}/20"),
                                        trailing: doc.get('exam_result') > 9
                                            ? const Text("Geslaagd")
                                            : const Text("Niet geslaagd")),
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
          ]),
        ),
      ),
    );
  }
}
