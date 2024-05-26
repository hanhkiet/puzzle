class MentalArithmetic {
  late String currentQuestion;
  List<String> questionList;
  int answer;
  late int answerLength;

  MentalArithmetic({required this.questionList, required this.answer}) {
    currentQuestion = questionList[0];
    answerLength = answer.toString().trim().length;
  }

  @override
  String toString() {
    return 'CalculatorQandS{question: $questionList, answer: $answer}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MentalArithmetic &&
          runtimeType == other.runtimeType &&
          questionList == other.questionList;

  @override
  int get hashCode => questionList.hashCode;
}
