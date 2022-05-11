class StudentAnswer {
  String? answerText;
  bool? answer;

  StudentAnswer({
    this.answerText,
    this.answer,
  });

  @override
  String toString() {
    String base = '\n answerText: $answerText \n answer: $answer';
    return base;
  }
}
