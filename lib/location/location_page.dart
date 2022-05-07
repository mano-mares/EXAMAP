// https://stackoverflow.com/questions/64917744/cannot-run-with-sound-null-safety-because-dependencies-dont-support-null-safety
// https://doctorcodetutorial.blogspot.com/2021/03/make-map-app-using-flutter.html

import 'package:flutter/material.dart';

import '../app_bar/my_app_bar.dart';
import 'strings.dart' as strings;
import '../res/style/my_fontsize.dart' as sizes;
import 'my_map.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
          automaticallyImplyLeading: true, appBarTitle: strings.appBarTitle),
      body: Center(
        child: Column(
          children: [
            Container(
              child: const Text(
                strings.textLabel +
                    "2", //TODO: replace with variable of correct student
                style: TextStyle(
                  fontSize: sizes.subTitle,
                ),
              ),
              padding: const EdgeInsets.only(bottom: 50.0),
            ),
            Container(
              child: SizedBox(
                width: 800.0,
                height: 500.0,
                child: MapApp(), 
              ),
              padding: const EdgeInsets.only(bottom: 20.0),
            ),
            Container(
              child: Text(
                strings.address +
                    "Ellermanstraat 33, Antwerpen" , //TODO: replace with variable of correct address
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
