import 'package:puzzle/data/models/quiz_model.dart';
import 'package:puzzle/data/random_dual_data.dart';

class DualRepository {
  static List<int> listHasCode = <int>[];

  static getDualData(int level) {
    if (level == 1) {
      listHasCode.clear();
    }

    List<QuizModel> list = <QuizModel>[];

    RandomDualData learnData = RandomDualData(level);
    while (list.length < 5) {
      list.add(learnData.getMethods());
    }

    return list;
  }
}

void main() {
  for (int i = 1; i < 5; i++) {
    DualRepository.getDualData(i);
  }
}
