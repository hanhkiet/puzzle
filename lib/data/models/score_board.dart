class ScoreBoard {
  int highestScore;
  late bool firstTime;

  ScoreBoard({required this.highestScore});

  ScoreBoard.fromJson(Map<String, dynamic> json)
      : highestScore = json['highestScore'] ?? 0,
        firstTime = json['firstTime'] ?? true;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['highestScore'] = highestScore;
    data['firstTime'] = firstTime;
    return data;
  }
}
