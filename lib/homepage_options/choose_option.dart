import 'package:examap/Student/choose_student_number/choose_student_page.dart';
import 'package:examap/authentication/login_page.dart';
import 'package:examap/location/location_page.dart';
import 'package:flutter/material.dart';

import '../res/style/my_fontsize.dart' as sizes;

class ChooseOption extends StatelessWidget {
  const ChooseOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChooseStudentPage()),
            );
          },
          child: const Text(
            "Student",
            style: TextStyle(fontSize: sizes.btnMedium),
          ),
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(240, 80), primary: Colors.red),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
          child: const Text(
            "Docent",
            style: TextStyle(fontSize: sizes.btnMedium),
          ),
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(240, 80), primary: Colors.red),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LocationPage()),
            );
          },
          child: const Text(
            "Location",
            style: TextStyle(fontSize: sizes.btnMedium),
          ),
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(240, 80), primary: Colors.red),
        ),
      ],
    );
  }
}
