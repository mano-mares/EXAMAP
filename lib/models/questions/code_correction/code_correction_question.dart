import 'package:examap/models/questions/question.dart';

class CodeCorrectionQuestion extends Question {
  String answerText;

  CodeCorrectionQuestion({
    required String id,
    required String questionText,
    required this.answerText,
    required int maxPoint,
    required String questionType,
  }) : super(
          id: id,
          questionText: questionText,
          maxPoint: maxPoint,
          questionType: questionType,
        );

  @override
  String toString() {
    return super.toString() + '\n answerText $answerText';
  }
}
