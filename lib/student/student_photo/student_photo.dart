import 'dart:io';
import 'package:examap/student/student_exam/student_exam.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
import '../../res/style/my_fontsize.dart' as fontSizes;

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
      //TODO: Change student number dynamically
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
        title: const Text(
          'Start examen',
          style: TextStyle(fontSize: fontSizes.medium),
        ),
        content: const Text(
          'Na het bevestigen begint je examen',
          style: TextStyle(fontSize: fontSizes.small),
        ),
        actions: [
          TextButton(
            child: const Text(
              'Sluit',
              style: TextStyle(fontSize: fontSizes.small),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            onPressed: () {
              uploadPhoto();

              // Push student exam page and remove all previous pages
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const StudentExam(),
                ),
                ((route) => false),
              );
            },
            child: const Padding(
              padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              child: Text(
                "Bevestig",
                style: TextStyle(fontSize: fontSizes.btnMedium),
              ),
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
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 50, 10, 40),
                  width: 450,
                  child: const Text(
                    "Voor de bevestiging van je identiteit vragen we je om een foto te nemen van jou met je studentenkaart",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSizes.subTitle,
                    ),
                  ),
                ),
              ),
              isPhotoTaken
                  ? Expanded(
                      flex: 4,
                      child: Image.file(
                        File(image!.path),
                      ),
                    )
                  : Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(),
                        child: controller == null
                            ? const Center(child: Text("Loading Camera..."))
                            : !controller!.value.isInitialized
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CameraPreview(controller!),
                      ),
                    ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isPhotoTaken
                          ? FloatingActionButton(
                              onPressed: retakePhoto,
                              child: const Icon(Icons.replay_rounded),
                            )
                          : const Text(""),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: FloatingActionButton(
                            onPressed: takePhoto,
                            child: const Icon(Icons.camera)),
                      ),
                      isPhotoTaken
                          ? ElevatedButton(
                              onPressed: confirmPhoto,
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                child: const Text(
                                  "Bevestig",
                                  style:
                                      TextStyle(fontSize: fontSizes.btnMedium),
                                ),
                              ),
                            )
                          : const Text(""),
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
