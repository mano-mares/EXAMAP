class Question {
  String id;
  String questionText;
  int maxPoint;
  String questionType;

  Question({
    required this.id,
    required this.questionText,
    required this.maxPoint,
    required this.questionType,
  });

  @override
  String toString() {
    String base = 'QUESTION';
    base +=
        '\n id: $id\n questionType: $questionType\n questionText: $questionText\n maxPoint: $maxPoint';
    return base;
  }
}
