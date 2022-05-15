import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examap/firebase_options.dart';
import 'package:examap/student/student_exam/strings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'strings.dart' as strings;
import '../../res/style/my_fontsize.dart' as sizes;
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  late FirebaseFirestore firestore;
  late String address;
  late double longitude, lattitude;
  Future<void> loadFirestore() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    firestore = FirebaseFirestore.instance;
  }

  Future<DocumentSnapshot> getStudent() async {
    await loadFirestore();
    final DocumentReference documentReference = firestore
        .collection('EXAMAP')
        .doc('exam')
        .collection('students')
        .doc(widget.studentNumber);

    final DocumentSnapshot studentDoc = await documentReference.get();

    return studentDoc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appBarTitle),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: getStudent(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          Widget page;
          if (snapshot.hasData) {
            // Get address from snapshot object
            address = snapshot.data!['address'] as String;
            longitude = snapshot.data!['location']['longitude'];
            lattitude = snapshot.data!['location']['lattitude'];
            //page = Text('Adres: $address, long: $longitude, lat: $lattitude');
            page = GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            );
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
