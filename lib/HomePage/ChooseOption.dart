import 'package:flutter/material.dart';

class ChooseOption extends StatelessWidget {
  void ChooseStudent() {
    print('Student chosen');
  }

  void ChooseDocent() {
    print('Docent chosen');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: ChooseStudent,
            child: Text(
              "Student",
              style: new TextStyle(fontSize: 30.0),
            ),
            style: ElevatedButton.styleFrom(
                fixedSize: Size(240, 80), primary: Colors.redAccent[700])),
        ElevatedButton(
          onPressed: ChooseDocent,
          child: Text(
            "Docent",
            style: new TextStyle(fontSize: 30.0),
          ),
          style: ElevatedButton.styleFrom(
              fixedSize: Size(240, 80), primary: Colors.redAccent[700]),
        ),
      ],
    );
  }
}
