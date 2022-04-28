import 'package:flutter/material.dart';
import 'students.dart';

class ChooseStudentPage extends StatefulWidget {
  const ChooseStudentPage({Key? key}) : super(key: key);

  @override
  State<ChooseStudentPage> createState() => _ChooseStudentPageState();
}

class _ChooseStudentPageState extends State<ChooseStudentPage> {
  final studentNumberController = TextEditingController();
  bool flagWrongStudentNumber = false;

  void checkStudent() {
    if (studentNumbers.contains(studentNumberController.text.trim()) == true) {
      //navigat to next page
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Foutief studentennummer!'),
          content: const Text('Voer een geldig studentennummer in'),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      title: 'Choose Student',
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
            title: const Text('Student')),
        body: Stack(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.2,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: size.height * 0.2 - 27,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.only(top: 50),
                      child: const Text(
                        "Voer je studentennummer in",
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(50, 150, 50, 0),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 10),
                              blurRadius: 50,
                              color: Colors.grey.withOpacity(
                                (0.23),
                              ),
                            )
                          ]),
                      child: TextFormField(
                        controller: studentNumberController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: "Studentennummer",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 200),
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(25)),
                ),
                onPressed: checkStudent,
                child: const Text(
                  "Ga verder",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 400),
              child: Image.asset(
                'assets/images/undraw_exams.png',
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
