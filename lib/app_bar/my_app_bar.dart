import 'package:flutter/material.dart';

import '../authentication/popup_menu_button_logout.dart';
import '../admin/homepage_docent/strings.dart' as strings;

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appBarTitle),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: const [
          PopupMenuButtonLogout(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
