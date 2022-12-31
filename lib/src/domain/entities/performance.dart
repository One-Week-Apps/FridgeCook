import 'package:fridge_cook/src/domain/entities/performance_score.dart';

class Performance {
  int id;
  DateTime dateTime;
  PerformanceScore score;

  Performance(this.id, this.score, this.dateTime);

  Performance.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        score = PerformanceScore(
            json['score'][0],
            json['score'][1],
            json['score'][2],
            json['score'][3],
            json['score'][4],
            json['score'][5],
            json['score'][6]),
        dateTime = DateTime.fromMillisecondsSinceEpoch(json['dateTime']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'dateTime': dateTime.millisecondsSinceEpoch,
        'score': [
          score.tempo,
          score.bodyMovement,
          score.tracing,
          score.hairBrushes,
          score.blocks,
          score.locks,
          score.handToss
        ]
      };
}
