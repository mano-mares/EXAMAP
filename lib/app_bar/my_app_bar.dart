import 'package:flutter/material.dart';
import '../homepage_docent/strings.dart' as strings;

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appBarTitle),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<Text>(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text(
                    strings.logOutAppBarPopupMenuItemTxt,
                  ),
                ),
              ];
            },
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
