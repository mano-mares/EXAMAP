import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examap/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'strings.dart' as strings;
import '../../res/style/my_fontsize.dart' as sizes;

class StudentLocation extends StatefulWidget {
  String studentNumber;
  StudentLocation({
    Key? key,
    required this.studentNumber,
  }) : super(key: key);

  @override
  State<StudentLocation> createState() => _StudentLocationState();
}

class _StudentLocationState extends State<StudentLocation> {
  late FirebaseFirestore firestore;
  late String address;
  Future<void> loadFirestore() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    firestore = FirebaseFirestore.instance;
  }

  Future<String> getAddress() async {
    await loadFirestore();
    final DocumentReference documentReference = firestore
        .collection('EXAMAP')
        .doc('exam')
        .collection('students')
        .doc(widget.studentNumber);

    final DocumentSnapshot studentDoc = await documentReference.get();

    return studentDoc['address'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appBarTitle),
        centerTitle: true,
      ),
      body: FutureBuilder<String>(
        future: getAddress(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          Widget page;
          if (snapshot.hasData) {
            // Get address from snapshot object
            address = snapshot.data as String;
            page = Text('Adres: $address');
          } else if (snapshot.hasError) {
            page = Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            page = Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'Retrieving address...',
                      style: TextStyle(fontSize: sizes.medium),
                    ),
                  )
                ],
              ),
            );
          }
          return page;
        },
      ),
    );
  }
}
