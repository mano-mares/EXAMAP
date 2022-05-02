import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../homepage_docent/strings.dart' as strings;
import '../main.dart';

class PopupMenuButtonLogout extends StatelessWidget {
  const PopupMenuButtonLogout({Key? key}) : super(key: key);

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Text>(
      onSelected: (value) {
        _signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
      },
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: Text('signout'),
            child: Text(
              strings.logOutAppBarPopupMenuItemTxt,
            ),
          ),
        ];
      },
    );
  }
}
