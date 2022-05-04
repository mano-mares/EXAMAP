import 'package:flutter/material.dart';

import '../authentication/popup_menu_button_logout.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key, required this.appBarTitle, this.automaticallyImplyLeading = false}) : super(key: key);

  final String appBarTitle;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
        automaticallyImplyLeading: automaticallyImplyLeading,
        actions: const [
          PopupMenuButtonLogout(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
