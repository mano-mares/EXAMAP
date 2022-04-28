import 'package:examap/models/questions/multiple_choice/answer.dart';
import 'package:examap/models/questions/question.dart';

class MultipleChoiceQuestion extends Question {
  List<Answer> possibleAnswers = [];

  MultipleChoiceQuestion({
    required String id,
    required String questionText,
    required int maxPoint,
    required String questionType,
    required this.possibleAnswers,
  }) : super(
            id: id,
            questionText: questionText,
            maxPoint: maxPoint,
            questionType: questionType);

  @override
  String toString() {
    String base = super.toString();
    base += '\nANSWERS';
    for (var answer in possibleAnswers) {
      base += '\n$answer';
      base += '\n';
    }
    return base;
  }
}
