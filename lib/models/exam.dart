class Exam {
  String _subject = '';
  String _timeLimit = '';

  // TODO: add list of students.

  // TODO: add list of questions.

  Exam(this._subject, this._timeLimit);

  // Getters and setters.
  String get subject => _subject;
  set subject(String value) => _subject = value;

  String get timeLimit => _timeLimit;
  set timeLimit(String value) => _timeLimit = value;
}
