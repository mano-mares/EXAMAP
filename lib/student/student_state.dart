import 'package:geolocator/geolocator.dart';

class StudentState {
  static String studentNumber = '';
  static int? studentTimesLeftExam = 0;
  static Position? position;
  static void clear() {
    studentNumber = '';
    studentTimesLeftExam = 0;
  }
}
