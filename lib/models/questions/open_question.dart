import 'package:examap/models/questions/question.dart';

class OpenQuestion extends Question {
  OpenQuestion(
      {required String id,
      required String questionText,
      required int maxPoint,
      required String questionType})
      : super(
            id: id,
            questionText: questionText,
            maxPoint: maxPoint,
            questionType: questionType);
}
