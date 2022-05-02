class Answer {
  String? answerText;
  bool? isCorrect;

  Answer({
    this.answerText,
    this.isCorrect,
  });

  @override
  String toString() {
    String base = '\n answerText: $answerText \n isCorrect: $isCorrect';
    return base;
  }
}
