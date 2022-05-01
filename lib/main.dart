import 'package:examap/create_exam/create_exam.dart';
import 'package:examap/student_list/student_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homepage_options/choose_option.dart';
import 'models/exam.dart';
import 'res/style/my_fontsize.dart' as sizes;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Choose Student',
        theme: ThemeData(primarySwatch: Colors.red),
        home: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text('Student')),
            body: StudentList()));
  }
}


// return MaterialApp(
//         title: 'Choose Student',
//         theme: ThemeData(primarySwatch: Colors.red),
//         home: Scaffold(
//           appBar: AppBar(),
//           body: Column(
//             children: [
//               Container(
//                 child: const Text(
//                   "EXAMAP!",
//                   style: TextStyle(
//                     fontSize: sizes.title,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 padding: const EdgeInsets.only(
//                   bottom: 100.0,
//                 ),
//               ),
//               Container(
//                 child: const Text(
//                   "Gelieve je rol te kiezen",
//                   style: TextStyle(
//                     fontSize: sizes.subTitle,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 padding: const EdgeInsets.only(bottom: 100.0),
//               ),
//               ChooseOption(),
//             ],
//             mainAxisAlignment: MainAxisAlignment.center,
//           ),
//         ),
//       ),
//     );