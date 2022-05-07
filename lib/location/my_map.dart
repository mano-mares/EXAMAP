import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';

class MapApp extends StatefulWidget {
  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  // double long = 49.5;
  // double lat = -0.09;
  LatLng point = LatLng(51.23007740985662, 4.416186427790708);
  var location = [];
  late Position _currentPosition;
  late String _currentAddress = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            // onTap: (p) async {
            //   location = await Geocoder.local.findAddressesFromCoordinates(
            //       new Coordinates(p.latitude, p.longitude));

            //   setState(() {
            //     point = p;
            //     print(p);
            //   });

            //   print(
            //       "${location.first.countryName} - ${location.first.featureName}");
            //   print(
            //       "${location.first.countryName},${location.first.locality}, ${location.first.featureName}");
            // },
            center: LatLng(51.23007740985662, 4.416186427790708),
            zoom: 18.0,
            debug: true,
            // plugins: [
            //   LocationMarkerPlugin(), // <-- add plugin here
            // ],
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            // LocationMarkerLayerOptions(),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: point,
                  builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ],
          // children: [
          //   TileLayerWidget(
          //     options: TileLayerOptions(
          //       urlTemplate:
          //           'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          //       subdomains: ['a', 'b', 'c'],
          //       maxZoom: 19,
          //     ),
          //   ),
          //   // LocationMarkerLayerWidget(
          //   //   options: LocationMarkerLayerOptions(
          //   //     marker: const DefaultLocationMarker(
          //   //       color: Colors.red,
          //   //       child: Icon(
          //   //         Icons.person,
          //   //         color: Colors.red,
          //   //       ),
          //   //     ),
          //   //     markerSize: const Size(100, 100),
          //   //     accuracyCircleColor: Colors.green.withOpacity(0.1),
          //   //     headingSectorColor: Colors.green.withOpacity(0.8),
          //   //     headingSectorRadius: 120,
          //   //     markerAnimationDuration: Duration.zero, // disable animation
          //   //   ),
          //   // ),
          // ],
        ),
      ],
    );
  }
}
