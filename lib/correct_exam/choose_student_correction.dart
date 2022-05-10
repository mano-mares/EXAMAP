import 'package:flutter/material.dart';
import '../res/style/my_fontsize.dart' as sizes;

class ChooseStudentCorrection extends StatefulWidget {
  const ChooseStudentCorrection({Key? key}) : super(key: key);

  @override
  State<ChooseStudentCorrection> createState() => _ChooseStudentCorrection();
}

class _ChooseStudentCorrection extends State<ChooseStudentCorrection> {
  void chooseStudent() {
    print("Choose student");
  }

  final items = List.generate(70, (counter) => 'Item: $counter');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Correct exam',
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
        body: Center(
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                "Examen verbeteren",
                style: TextStyle(
                  fontSize: sizes.large,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Studenten",
                style: TextStyle(
                  fontSize: sizes.medium,
                ),
              ),
            ),
            const Text(
              "Kies een student waarvan je het examen wenst te verbeteren",
              style: TextStyle(
                fontSize: sizes.small,
              ),
            ),
            Container(
              color: Colors.grey,
              child: Column(
                children: [
                  const Text(
                    "Niet verbeterd",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: sizes.medium, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 30, 80, 30),
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item),
                                Text("Punten"),
                                Text("Klik hier")
                              ],
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
