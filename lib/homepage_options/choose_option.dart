import 'package:flutter/material.dart';

class ChooseOption extends StatelessWidget {
  void chooseStudent() {
    //Navigation to student
  }

  void chooseDocent() {
    //Navigation to teacher
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: chooseStudent,
            child: Text(
              "Student",
              style: new TextStyle(fontSize: 30.0),
            ),
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(240, 80), primary: Colors.red)),
        ElevatedButton(
          onPressed: chooseDocent,
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
