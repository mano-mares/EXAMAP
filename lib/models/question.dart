import 'package:examap/create_exam/question_type.dart';

class Question {
  int id;
  String questionText;
  int maxPoint;
  String questionType;

  Question(
      {required this.id,
      required this.questionText,
      required this.maxPoint,
      required this.questionType});
}
