import 'package:examap/admin/homepage_docent/homepage_docent.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../res/style/my_fontsize.dart' as sizes;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool wrongLogin = false;
  bool passwordHidden = false;
  void passwordForgot() {
    auth.sendPasswordResetEmail(email: emailController.text.trim());
  }

  void togglePasswordView() {
    setState(() {
      passwordHidden = !passwordHidden;
    });
  }

  void loginFirebase() async {
    try {
      formKey.currentState!.validate();
      setState(() {
        wrongLogin = false;
      });
      await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      if (auth.currentUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePageDocent()),
        );
      }
    } catch (e) {
      setState(() {
        wrongLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100.0),
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(100, 100, 100, 20),
              child: const Text(
                "Log in",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizes.title,
                ),
              )),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: const Text("Docent",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: sizes.subTitle))),
          Form(
              key: formKey,
              child: Column(children: [
                Container(
                    padding: const EdgeInsets.fromLTRB(100, 0, 100, 15),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is vereist';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Email'),
                    )),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(100, 0, 100, 5),
                  child: TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Wachtwoord is vereist';
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: !passwordHidden,
                      decoration: InputDecoration(
                          fillColor: Colors.red,
                          border: const OutlineInputBorder(),
                          labelText: 'Wachtwoord',
                          suffix: InkWell(
                              onTap: togglePasswordView,
                              child: Icon(passwordHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off)))),
                ),
              ])),
          Container(
            padding: const EdgeInsets.fromLTRB(100, 5, 0, 0),
            child: Visibility(
                visible: wrongLogin,
                child: wrongLogin
                    ? const Text("U heeft een verkeerde login ingevoerd",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ))
                    : const Text("")),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(100, 5, 0, 0),
            child: InkWell(
              child: Container(
                child: const Text("Wachtwoord vergeten?",
                    style: TextStyle(color: Colors.red)),
              ),
              onTap: passwordForgot,
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(190, 30, 190, 0),
              child: ElevatedButton(
                child: const Text("Log in"),
                onPressed: loginFirebase,
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: sizes.btnSmall, fontWeight: FontWeight.bold)),
              )),
        ],
      ),
    );
  }
}
