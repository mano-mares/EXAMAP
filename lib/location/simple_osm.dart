// https://github.com/liodali/osm_flutter/blob/master/example/lib/src/home/home_example.dart
// https://pub.dev/packages/geolocator

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class SimpleOSM extends StatefulWidget {
  const SimpleOSM({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SimpleOSMState();
}

class SimpleOSMState extends State<SimpleOSM>
    with AutomaticKeepAliveClientMixin {
  late MapController controller;
  String userLocation = "";
  var location = [];
  late List<Placemark> placemarks;

  Future<void> start()  async {
    Position position = await Geolocator.getCurrentPosition();
    // placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
    print("+++++++++++++++++");
    print(position);
  }

  @override
  void initState() {
    super.initState();
    controller = MapController(
      initMapWithUserPosition: false,
      initPosition:
          GeoPoint(latitude: 51.23007740985662, longitude: 4.416186427790708),
    );
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);

    return OSMFlutter(
      controller: controller,
      trackMyPosition: true,
      androidHotReloadSupport: true,
      mapIsLoading: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const Text("Map is Loading..."),
          ],
        ),
      ),
      onMapIsReady: (isReady) {
        if (isReady) {
          print("map is ready");
        }
      },
      initZoom: 19,
      minZoomLevel: 17,
      maxZoomLevel: 14,
      stepZoom: 1.0,
      userLocationMarker: UserLocationMaker(
        personMarker: const MarkerIcon(
          icon: Icon(
            Icons.location_history_rounded,
            color: Colors.red,
            size: 150,
          ),
        ),
        directionArrowMarker: const MarkerIcon(
          icon: Icon(
            Icons.double_arrow,
            size: 150,
          ),
        ),
      ),
      // showContributorBadgeForOSM: true,
      onLocationChanged: (myLocation) {
        print(myLocation);
      },
      staticPoints: [
        StaticPositionGeoPoint(
          "line 1",
          const MarkerIcon(
            icon: Icon(
              Icons.location_history_rounded,
              color: Colors.red,
              size: 80,
            ),
          ),
          [
            GeoPoint(latitude: 51.23007740985662, longitude: 4.416186427790708),  // TODO: Here change to user location
          ],
        ),
      ],
      roadConfiguration: RoadConfiguration(
        startIcon: const MarkerIcon(
          icon: const Icon(
            Icons.person,
            size: 64,
            color: Colors.brown,
          ),
        ),
        middleIcon: const MarkerIcon(
          icon: Icon(Icons.location_history_sharp),
        ),
        roadColor: Colors.red,
      ),
      markerOption: MarkerOption(
        defaultMarker: const MarkerIcon(
          icon: const Icon(
            Icons.home,
            color: Colors.orange,
            size: 64,
          ),
        ),
        advancedPickerMarker: const MarkerIcon(
          icon: const Icon(
            Icons.location_searching,
            color: Colors.green,
            size: 64,
          ),
        ),
      ),
      showDefaultInfoWindow: true,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
