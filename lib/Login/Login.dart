import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  void passwordForgot() {
    print("Verstuur wachtwoord vergeten mail");
  }

  void loginFirebase() {
    print("Login");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(100.0),
        child: ListView(children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(100, 100, 100, 20),
              child: const Text(
                "Log in",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                ),
              )),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: const Text("Docent",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0))),
          Container(
              padding: const EdgeInsets.fromLTRB(100, 0, 100, 15),
              child: const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Username'),
              )),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(100, 0, 100, 5),
            child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password')),
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
                        fontSize: 20, fontWeight: FontWeight.bold)),
              )),
        ]));
  }
}
