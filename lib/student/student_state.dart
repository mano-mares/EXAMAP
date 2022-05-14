import 'package:geolocator/geolocator.dart';

class StudentState {
  static String studentNumber = '';
  static int? studentTimesLeftExam = 0;
  static Position? position;
  static String? address;
  static void clear() {
    studentNumber = '';
    studentTimesLeftExam = 0;
    position = null;
    address = '';
  }
}
