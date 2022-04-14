import 'package:examap/Login/Login.dart';
import 'package:examap/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
              // onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text('Login page')),
        body: FutureBuilder(
          future:
              Firebase.initializeApp(options: DefaultFirebaseOptions.android),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Login();
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
