import 'package:examap/create_exam/create_exam_form/question_card.dart';
import 'package:flutter/cupertino.dart';
import '../create_exam/constant.dart' as constant;

class Exam with ChangeNotifier {
  String _subject = '';
  String _timeLimit = '';

  // TODO: add list of students.
  List<Widget> _questions = [
    QuestionCard(
        index: 1,
        questionText: 'Leg het verschil uit tussen een stack en een heap.',
        questionType: constant.openQuestion,
        points: 3),
    QuestionCard(
        index: 2,
        questionText: 'Welk datatype is 5.699?',
        questionType: constant.multipleChoice,
        points: 2),
    QuestionCard(
        index: 3,
        questionText: 'Herschrijf de opgegeven code tot dat het werkt.',
        questionType: constant.codeCorrection,
        points: 2),
    QuestionCard(
        index: 4,
        questionText: 'Leg het verchil uit tussen een float en een double.',
        questionType: constant.openQuestion,
        points: 3),
    QuestionCard(
        index: 5,
        questionText: 'Wat is geen programeertaal uit de volgende opties?',
        questionType: constant.multipleChoice,
        points: 1),
    QuestionCard(
        index: 6,
        questionText: 'Herschrijf de opgegeven code tot dat het werkt.',
        questionType: constant.codeCorrection,
        points: 2),
  ];

  Exam(this._subject, this._timeLimit);

  // Getters and setters.
  String get subject => _subject;
  set subject(String value) => _subject = value;

  String get timeLimit => _timeLimit;
  set timeLimit(String value) => _timeLimit = value;

  List<Widget> get questions => _questions;

  void removeQuestion(int index) {
    // TODO: remove a question from the list.
    print('remove question with index $index');

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
