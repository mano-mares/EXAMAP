import 'package:examap/models/question.dart';

class OpenQuestion extends Question {
  OpenQuestion(
      {required int id,
      required String questionText,
      required int maxPoint,
      required String questionType})
      : super(
            id: id,
            questionText: questionText,
            maxPoint: maxPoint,
            questionType: questionType);
}
