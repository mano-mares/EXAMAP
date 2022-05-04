import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../app_bar/my_app_bar.dart';
import 'simple_osm.dart';
import 'strings.dart' as strings;
import '../res/style/my_fontsize.dart' as sizes;

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
              child: const SizedBox(
                width: 800.0,
                height: 500.0,
                child: SimpleOSM(), //OSM = OpenStreetMap
              ),
              padding: const EdgeInsets.only(bottom: 20.0),
            ),
            Container(
              child: const Text(
                strings.address +
                    "Ellermanstraat 33, Antwerpen", //TODO: replace with variable of correct address
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
