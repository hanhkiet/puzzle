class MentalArithmetic {
  List<String> questionList;
  int answer;

  MentalArithmetic({required this.questionList, required this.answer});

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
