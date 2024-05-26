import 'dart:math';

import 'package:intl/intl.dart';

import 'models/find_missing_model.dart';

class RandomFindMissingData {
  int levelNo = 0;
  int firstDigit = 0;
  int secondDigit = 0;
  int answer = 0;
  double doubleAnswer = 0;
  String? question, tableName;
  String? multiplicationSign,
      space,
      additionSign,
      subtractionSign,
      divisionSign;
  int? dataTypeNumber = 1;

  double firstDoubleDigit = 0;
  double secondDoubleDigit = 0;

  int helpTag = 0;
  double digit_1 = 0, digit_2 = 0, digit_3 = 0, digit_4 = 0;
  FindMissingQuizModel quizModel = FindMissingQuizModel();
  String currentSign = "+";

  RandomFindMissingData(this.levelNo) {
    if (levelNo <= 5) {
      dataTypeNumber = 1;
    } else if (levelNo > 5 && levelNo <= 20) {
      dataTypeNumber = 2;
    } else if (levelNo > 20 && levelNo <= 30) {
      dataTypeNumber = 3;
    }

    additionSign = "+";
    multiplicationSign = "*";
    divisionSign = "/";
    subtractionSign = "-";
    space = "\u0020";
  }

  FindMissingQuizModel getMethods() {
    quizModel = FindMissingQuizModel();

    int i = Random().nextInt((4 - 1) + 1) + 1;
    currentSign = additionSign!;
    if (i == 1) {
      currentSign = additionSign!;
      return getAddition();
    } else if (i == 2) {
      currentSign = subtractionSign!;
      return getSubtraction();
    } else if (i == 3) {
      currentSign = multiplicationSign!;
      return getMultiplication();
    } else if (i == 4) {
      currentSign = divisionSign!;
      return getDivision();
    }
    return getAddition();
  }

  int getFirstMinNumber() {
    int number = 30;
    if (dataTypeNumber == 1) {
      number = 10;
    } else if (dataTypeNumber == 2) {
      number = 150;
    }

    return number;
  }

  int getFirstMaxNumber() {
    int number = 50;

    if (dataTypeNumber == 1) {
      number = 50;
    } else if (dataTypeNumber == 2) {
      number = 200;
    }

    return number;
  }

  int getSecondMaxNumber() {
    int number = 150;

    if (dataTypeNumber == 1) {
      number = 100;
    } else if (dataTypeNumber == 2) {
      number = 250;
    }

    return number;
  }

  int getSecondMinNumber() {
    int number = 150;

    if (dataTypeNumber == 1) {
      number = 50;
    } else if (dataTypeNumber == 2) {
      number = 200;
    }
    return number;
  }

  FindMissingQuizModel getAddition() {
    int firstMin = getFirstMinNumber();
    int secondMin = getSecondMinNumber();
    int firstMax = getFirstMaxNumber();
    int secondMax = getSecondMaxNumber();

    firstDigit = Random().nextInt((firstMax - firstMin) + 1) + firstMin;
    secondDigit = Random().nextInt((secondMax - secondMin) + 1) + secondMin;

    answer = firstDigit + secondDigit;
    addModel();

    if (helpTag == 1) {
      question = "? $currentSign $secondDigit = ${firstDigit + secondDigit}";
    } else if (helpTag == 2) {
      question = "$firstDigit $currentSign ? = ${firstDigit + secondDigit}";
    } else {
      question = "$firstDigit $currentSign $secondDigit = ?";
    }

    quizModel.question = question;
    return quizModel;
  }

  FindMissingQuizModel getSubtraction() {
    if (dataTypeNumber == 1) {
      firstDigit = Random().nextInt(50) + 10;
      secondDigit = Random().nextInt(30) + 3;
    } else if (dataTypeNumber == 2) {
      firstDigit = Random().nextInt((100 - 50) + 1) + 50;
      secondDigit = Random().nextInt((50 - 10) + 1) + 10;
    } else {
      firstDigit = Random().nextInt((500 - 200) + 1) + 200;
      secondDigit = Random().nextInt((200 - 100) + 1) + 100;
    }

    answer = firstDigit - secondDigit;

    addModel();

    if (helpTag == 1) {
      question = "? $currentSign $secondDigit = ${firstDigit - secondDigit}";
    } else if (helpTag == 2) {
      question = "$firstDigit $currentSign ? = ${firstDigit - secondDigit}";
    } else {
      question = "$firstDigit $currentSign $secondDigit = ?";
    }
    quizModel.question = question;
    return quizModel;
  }

  FindMissingQuizModel getMultiplication() {
    if (dataTypeNumber == 1) {
      firstDigit = Random().nextInt(5) + 1;
      secondDigit = Random().nextInt(5) + 1;
    } else if (dataTypeNumber == 2) {
      firstDigit = Random().nextInt(30) + 1;
      secondDigit = Random().nextInt(30) + 1;
    } else {
      firstDigit = Random().nextInt(80) + 5;
      secondDigit = Random().nextInt(30) + 5;
    }

    answer = firstDigit * secondDigit;

    addModel();

    if (helpTag == 1) {
      question = "? $currentSign $secondDigit = ${firstDigit * secondDigit}";
    } else if (helpTag == 2) {
      question = "$firstDigit $currentSign ? = ${firstDigit * secondDigit}";
    } else {
      question = "$firstDigit $currentSign $secondDigit = ?";
    }
    quizModel.question = question;
    return quizModel;
  }

  FindMissingQuizModel getDivision() {
    double n1, n2;

    if (dataTypeNumber == 1) {
      n1 = Random().nextInt((40 - 10) + 1) + 5;
      n2 = Random().nextInt((10 - 5) + 1) + 5;
    } else if (dataTypeNumber == 2) {
      n1 = Random().nextInt((100 - 50) + 1) + 50;
      n2 = Random().nextInt((10 - 5) + 1) + 5;
    } else {
      n1 = Random().nextInt((200 - 100) + 1) + 100;
      n2 = Random().nextInt((100 - 50) + 1) + 50;
    }

    doubleAnswer = n1 / n2;

    firstDoubleDigit = n1;
    secondDoubleDigit = n2;

    addDoubleModel();

    if (helpTag == 1) {
      question =
          "? $currentSign ${secondDoubleDigit.toInt()} = ${getFormattedString((firstDoubleDigit / secondDoubleDigit))}";
    } else if (helpTag == 2) {
      question =
          "${firstDoubleDigit.toInt()} $currentSign ? = ${getFormattedString((firstDoubleDigit / secondDoubleDigit))}";
    } else {
      question =
          "${firstDoubleDigit.toInt()} $currentSign ${secondDoubleDigit.toInt()} = ?";
    }
    quizModel.question = question;
    return quizModel;
  }

  void addModel() {
    helpTag = Random().nextInt(3) + 1;
    if (helpTag == 1) {
      answer = firstDigit;
    } else if (helpTag == 2) {
      answer = secondDigit;
    }

    int op_1 = answer + 10;
    int op_2 = answer - 10;
    if (op_2 < 0) {
      op_2 = answer + 15;
    }
    int op_3 = answer + 20;

    List<String> stringList = [];
    stringList.add(op_1.toString());
    stringList.add(op_2.toString());
    stringList.add(op_3.toString());
    stringList.add(answer.toString());

    quizModel.answer = answer.toString();

    shuffle(stringList);
    quizModel.optionList = (stringList);
    quizModel.question = question;
  }

  void addSingleModel() {
    helpTag = Random().nextInt(2) + 1;
    if (helpTag == 1) {
      answer = firstDigit;
    }

    int op_1 = answer + 10;
    int op_2 = answer - 10;
    if (op_2 < 0) {
      op_2 = answer + 15;
    }
    int op_3 = answer + 20;

    List<String> stringList = [];
    stringList.add(op_1.toString());
    stringList.add(op_2.toString());
    stringList.add(op_3.toString());
    stringList.add(answer.toString());

    quizModel.answer = answer.toString();
    shuffle(stringList);
    quizModel.optionList = (stringList);
    quizModel.question = question;
  }

  void addDoubleModel() {
    helpTag = Random().nextInt(3) + 1;
    if (helpTag == 1) {
      doubleAnswer = firstDoubleDigit;
    } else if (helpTag == 2) {
      doubleAnswer = secondDoubleDigit;
    }

    double opDouble1 = doubleAnswer + 10;
    double opDouble2 = doubleAnswer - 10;
    double opDouble3 = doubleAnswer + 20;

    if (opDouble2 < 0) {
      opDouble2 = doubleAnswer + 15;
    }

    List<String> stringList = [];
    stringList.add(getFormattedString(opDouble1));
    stringList.add(getFormattedString(opDouble2));
    stringList.add(getFormattedString(opDouble3));
    stringList.add(getFormattedString(doubleAnswer));

    quizModel.answer = getFormattedString(doubleAnswer);

    shuffle(stringList);
    quizModel.optionList = (stringList);
    quizModel.question = question;
  }

  void addDoubleSingleModel() {
    helpTag = Random().nextInt(2) + 1;
    if (helpTag == 1) {
      doubleAnswer = firstDoubleDigit;
    }

    double opDouble1 = doubleAnswer + 10;
    double opDouble2 = doubleAnswer - 10;
    if (opDouble2 < 0) {
      opDouble2 = doubleAnswer + 15;
    }
    double opDouble3 = doubleAnswer + 20;
    List<String> stringList = [];
    stringList.add(getFormattedString(opDouble1));
    stringList.add(getFormattedString(opDouble2));
    stringList.add(getFormattedString(opDouble3));
    stringList.add(getFormattedString(doubleAnswer));

    quizModel.answer = getFormattedString(doubleAnswer);

    shuffle(stringList);
    quizModel.optionList = (stringList);
    quizModel.question = question;
  }
}

List shuffle(List items) {
  var random = Random();

  // Go through all elements.
  for (var i = items.length - 1; i > 0; i--) {
    var n = random.nextInt(i + 1);

    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}

String getFormattedString(double d) {
  NumberFormat numberFormat = NumberFormat(".00", "en_US");

  return numberFormat.format(d);
}
