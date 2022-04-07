import 'package:examap/models/question.dart';
import 'package:flutter/cupertino.dart';
import '../create_exam/constant.dart' as constant;

class Exam with ChangeNotifier {
  String _subject = '';
  String _timeLimit = '';

  // TODO: add list of students.
  List<Question> _questions = [
    Question(
        id: 1,
        questionText: 'Leg het verschil uit tussen een stack en een heap.',
        questionType: constant.openQuestion,
        maxPoint: 3),
    Question(
        id: 2,
        questionText: 'Welk datatype is 5.699?',
        questionType: constant.multipleChoice,
        maxPoint: 2),
    Question(
        id: 3,
        questionText: 'Herschrijf de opgegeven code tot dat het werkt.',
        questionType: constant.codeCorrection,
        maxPoint: 2),
    Question(
        id: 4,
        questionText: 'Leg het verchil uit tussen een float en een double.',
        questionType: constant.openQuestion,
        maxPoint: 3),
    Question(
        id: 5,
        questionText: 'Wat is geen programeertaal uit de volgende opties?',
        questionType: constant.multipleChoice,
        maxPoint: 1),
    Question(
        id: 6,
        questionText: 'Herschrijf de opgegeven code tot dat het werkt.',
        questionType: constant.codeCorrection,
        maxPoint: 2),
  ];

  Exam();

  // Getters and setters.
  String get subject => _subject;
  set subject(String value) => _subject = value;

  String get timeLimit => _timeLimit;
  set timeLimit(String value) => _timeLimit = value;

  List<Question> get questions => _questions;

  void removeQuestionAt(int index) {
    _questions.removeAt(index);

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
