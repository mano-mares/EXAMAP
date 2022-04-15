import 'package:examap/authentication/login_page.dart';
import 'package:flutter/material.dart';

class ChooseOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            //Navigation to student
          },
          child: const Text(
            "Student",
            style: TextStyle(fontSize: 30.0),
          ),
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(240, 80), primary: Colors.red),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: const Text(
            "Docent",
            style: TextStyle(fontSize: 30.0),
          ),
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(240, 80), primary: Colors.red),
        ),
      ],
    );
  }
}
