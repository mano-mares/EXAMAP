import 'package:examap/models/question.dart';
import 'package:flutter/cupertino.dart';
import '../create_exam/strings.dart' as strings;

class Exam with ChangeNotifier {
  String _subject = '';
  String _timeLimit = '';

  List<Question> _questions = [];

  Exam();

  // Getters and setters.
  String get subject => _subject;
  set subject(String value) => _subject = value;

  String get timeLimit => _timeLimit;
  set timeLimit(String value) => _timeLimit = value;

  List<Question> get questions => _questions;

  void addQuestion(Question question) {
    _questions.add(question);
    notifyListeners();
  }

  void removeQuestionAt(int index) {
    _questions.removeAt(index);

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
