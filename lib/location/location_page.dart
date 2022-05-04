import 'package:flutter/material.dart';

import '../app_bar/my_app_bar.dart';
import '../res/style/my_fontsize.dart' as sizes;
import './strings.dart' as strings;

class LocationPage extends StatelessWidget {
  const LocationPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(automaticallyImplyLeading: true, appBarTitle: strings.appBarTitle),
       body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: const Text(
                strings.textLabel + "2",  //TODO: replace with variable of correct student
                style: TextStyle(
                  fontSize: sizes.subTitle,
                ),
              ),
              padding: const EdgeInsets.only(bottom: 50.0),
            ),
            Container(
              
              padding: const EdgeInsets.only(bottom: 50.0),
            ),
            Container(
              child: const Text(
                strings.address + "Ellermanstraat 33, Antwerpen",  //TODO: replace with variable of correct address
                style: TextStyle(
                  fontSize: sizes.medium,
                ),
              ),
              padding: const EdgeInsets.only(bottom: 50.0),
            ),
          ],
        ),
      ),
    );
  }
}