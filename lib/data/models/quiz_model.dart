class QuizModel {
  String? sign;
  String? rem;
  int? id;
  String? firstDigit;
  String? secondDigit, question;
  String? answer;
  String? op_1;
  String? op_2;
  String? op_3;

  List<String> optionList = [];

  QuizModel(String this.answer,
      {this.firstDigit,
      this.secondDigit,
      this.question,
      this.op_1,
      this.op_2,
      this.op_3}) {
    firstDigit = firstDigit;
    secondDigit = secondDigit;
    question = question;
    op_1 = op_1;
    op_2 = op_2;
    op_3 = op_3;
  }
}
