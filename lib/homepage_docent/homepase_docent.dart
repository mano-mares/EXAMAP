import 'package:flutter/material.dart';
import '../app_bar/my_app_bar.dart';
import './strings.dart' as strings;

class HomePageDocent extends StatelessWidget {
  const HomePageDocent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: const Text(
                strings.titleTxt,
                style: TextStyle(
                  fontSize: 55.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: const EdgeInsets.only(
                bottom: 20.0,
              ),
            ),
            Container(
              child: const Text(
                strings.subTitleTxt,
                style: TextStyle(
                  fontSize: 30.0,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              padding: const EdgeInsets.only(bottom: 50.0),
            ),
            ElevatedButton(
              child: const Text(strings.createExamBtnLabel),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(240, 80),
                  primary: Colors.red,
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () {}, //TODO: Redirect to Examen aanmaken page
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text(strings.correctExamBtnLabel),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(240, 80),
                  primary: Colors.red,
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () {}, //TODO: Redirect to Examen verbeteren page
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text(strings.studentListBtnLabel),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(240, 80),
                  primary: Colors.red,
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              onPressed: () {}, //TODO: Redirect to Studenten lijst page
            ),
          ],
        ),
      ),
    );
  }
}
