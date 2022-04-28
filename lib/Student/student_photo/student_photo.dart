import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:examap/main.dart';

class StudentPhoto extends StatefulWidget {
  const StudentPhoto({Key? key}) : super(key: key);
  @override
  State<StudentPhoto> createState() => _StudentPhotoState();
}

class _StudentPhotoState extends State<StudentPhoto> {
  void confirmPhoto() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Start examen'),
        content: const Text('Na het bevestigen begint je examen'),
        actions: [
          TextButton(
            child: const Text('Sluit'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            onPressed: () => {
              //Navigate to next page,
            },
            child: const Text(
              "Bevestig",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Take student photo',
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
        body: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 400,
                child: Text(
                  "Voor de bevestiging van je identiteit vragen we je om een foto te nemen van jou met je studentenkaart",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/camera_icon.png",
                      width: 50,
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: confirmPhoto,
                      child: const Text("Bevestig"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
