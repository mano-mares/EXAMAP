import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:provider/provider.dart';

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
    List<GeoPoint> geoPoints = [
      GeoPoint(latitude: 51.23007740985662, longitude: 4.416186427790708),
    ];
    // SimpleOSMState s = Provider.of<SimpleOSMState>(context);

    Future getUserLocation() async {
      try {
        await SimpleOSMState().controller.setStaticPosition(geoPoints, "5");
      } catch (e) {
        print(e.toString());
      }
      // return userLocation;
    }

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
              child: Text(
                strings.address +
                    "Ellermanstraat 33, Antwerpen " + SimpleOSMState().getUserLocation().toString(), //TODO: replace with variable of correct address
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
