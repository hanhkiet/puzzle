import 'package:puzzle/data/models/true_false_model.dart';
import 'package:puzzle/data/random_option_data.dart';

class TrueFalseRepository {
  static List<int> listHasCode = <int>[];

  static getTrueFalseDataList(int level) {
    if (level == 1) {
      listHasCode.clear();
    }

    List<TrueFalseModel> list = <TrueFalseModel>[];

    RandomOptionData learnData = RandomOptionData(level);
    learnData.setTrueFalseQuiz(true);
    while (list.length < 5) {
      list.add(learnData.getMethods());
    }

    return list;
  }
}

void main() {
  for (int i = 1; i < 5; i++) {
    TrueFalseRepository.getTrueFalseDataList(i);
  }
}