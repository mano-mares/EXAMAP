import 'package:examap/create_exam/create_exam.dart';
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
    return ChangeNotifierProvider(
      create: (context) => Exam(),
      child: MaterialApp(
        title: 'Choose type',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Container(
                child: const Text(
                  "EXAMAP!",
                  style: TextStyle(
                    fontSize: sizes.title,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                padding: const EdgeInsets.only(
                  bottom: 100.0,
                ),
              ),
              Container(
                child: const Text(
                  "Gelieve je rol te kiezen",
                  style: TextStyle(
                    fontSize: sizes.subTitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 100.0),
              ),
              ChooseOption(),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}
