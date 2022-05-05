import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';

class StudentPhoto extends StatefulWidget {
  const StudentPhoto({Key? key}) : super(key: key);
  @override
  State<StudentPhoto> createState() => _StudentPhotoState();
}

class _StudentPhotoState extends State<StudentPhoto> {
  bool isPhotoTaken = false;
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for caputred image
  @override
  void initState() {
    Firebase.initializeApp(options: DefaultFirebaseOptions.android);
    loadCamera();
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.max);
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("No cameras found");
    }
  }

  void takePhoto() async {
    isPhotoTaken = true;
    try {
      if (controller != null) {
        if (controller!.value.isInitialized) {
          image = await controller!.takePicture();
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void retakePhoto() {
    isPhotoTaken = false;
    setState(() {});
  }

  void uploadPhoto() async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      final ref = storage.ref().child('S112189');
      File uploadImage = File(image!.path);
      await ref.putFile(uploadImage);
    } catch (e) {
      print(e);
    }
    //navigate to exam screen
  }

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
            onPressed: uploadPhoto,
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
              Container(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 40),
                width: 450,
                child: const Text(
                  "Voor de bevestiging van je identiteit vragen we je om een foto te nemen van jou met je studentenkaart",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              isPhotoTaken
                  ? SizedBox(
                      height: 750,
                      width: 420,
                      child: Image.file(
                        File(image!.path),
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 750,
                          width: 420,
                          child: controller == null
                              ? const Center(child: Text("Loading Camera..."))
                              : !controller!.value.isInitialized
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CameraPreview(controller!),
                        ),
                      ],
                    ),
              Container(
                padding: const EdgeInsets.only(top: 30),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isPhotoTaken
                        ? Padding(
                            padding: const EdgeInsets.all(15),
                            child: FloatingActionButton(
                              onPressed: retakePhoto,
                              child: const Icon(Icons.replay_rounded),
                            ),
                          )
                        : const Text(""),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: FloatingActionButton(
                          onPressed: takePhoto,
                          child: const Icon(Icons.camera)),
                    ),
                    ElevatedButton(
                      onPressed: confirmPhoto,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: const Text(
                          "Bevestig",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
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
