import 'dart:convert';

import 'package:http/http.dart';

class HttpService {
  final String openstreetMapURI = 'https://nominatim.openstreetmap.org/reverse';

  static Future<String> getAddress(double lon, double lat) async {
    Response res = await get(Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon&zoom=18&addressdetails=1'));

    dynamic body = jsonDecode(res.body);

    dynamic addressJson = body['address'];

    //print(addressJson);
    String address =
        "${addressJson['road']} ${addressJson['house_number']}, ${addressJson['town']}";

    // List<User> posts = body
    //     .map(
    //       (dynamic item) => User.fromJson(item),
    //     )
    //     .toList();

    return address;
  }
}
