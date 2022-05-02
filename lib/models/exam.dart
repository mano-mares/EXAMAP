import 'package:examap/models/questions/question.dart';
import 'package:flutter/cupertino.dart';

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

  Question getQuestionAt(int index) {
    return _questions[index];
  }

  void removeQuestionAt(int index) {
    _questions.removeAt(index);

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  @override
  String toString() {
    String base = 'Exam\n Subject: $_subject\n Time: $_timeLimit\n';
    for (int i = 0; i < _questions.length; i++) {
      dynamic question = _questions[i];
      base += '$i. $question';
      base += '\n';
    }
    return base;
  }
}
