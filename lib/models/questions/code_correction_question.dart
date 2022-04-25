import 'package:examap/models/questions/question.dart';

class CodeCorrectionQuestion extends Question {
  CodeCorrectionQuestion(
      {required String id,
      required String questionText,
      required String answerText,
      required int maxPoint,
      required String questionType})
      : super(
            id: id,
            questionText: questionText,
            maxPoint: maxPoint,
            questionType: questionType);
}
