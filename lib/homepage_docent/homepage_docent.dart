import 'package:examap/create_exam/create_exam.dart';
import 'package:flutter/material.dart';

import '../app_bar/my_app_bar.dart';
import './strings.dart' as strings;
import '../res/style/my_fontsize.dart' as sizes;

class HomePageDocent extends StatelessWidget {
  const HomePageDocent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(appBarTitle: strings.appBarTitle),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: const Text(
                strings.titleTxt,
                style: TextStyle(
                  fontSize: sizes.title,
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
                  fontSize: sizes.subTitle,
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
                textStyle:
                    const TextStyle(fontSize: sizes.text, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateExamPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text(strings.correctExamBtnLabel),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(240, 80),
                primary: Colors.red,
                textStyle:
                    const TextStyle(fontSize: sizes.text, fontWeight: FontWeight.bold),
              ),
              onPressed: () {}, //TODO: Redirect to Examen verbeteren page
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text(strings.studentListBtnLabel),
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(240, 80),
                primary: Colors.red,
                textStyle:
                    const TextStyle(fontSize: sizes.text, fontWeight: FontWeight.bold),
              ),
              onPressed: () {}, //TODO: Redirect to Studenten lijst page
            ),
          ],
        ),
      ),
    );
  }
}
