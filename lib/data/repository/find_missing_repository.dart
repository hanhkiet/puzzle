import 'package:puzzle/data/models/find_missing_model.dart';
import 'package:puzzle/data/random_find_missing_data.dart';

class FindMissingRepository {
  static List<int> listHasCode = <int>[];

  static getFindMissingDataList(int level) {
    if (level == 1) {
      listHasCode.clear();
    }

    List<FindMissingQuizModel> list = <FindMissingQuizModel>[];

    RandomFindMissingData learnData = RandomFindMissingData(level);
    while (list.length < 5) {
      list.add(learnData.getMethods());
    }

    return list;
  }
}

void main() {
  for (int i = 1; i < 5; i++) {
    FindMissingRepository.getFindMissingDataList(i);
  }
}
