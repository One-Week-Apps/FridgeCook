import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_performance_repository.dart';
import 'package:fridge_cook/src/domain/entities/performance.dart';
import 'package:fridge_cook/src/domain/entities/performance_score.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // SharedPreferences.setMockInitialValues({});
  });

  tearDown(() async {
    // var prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
  });

  void _assert(List<Performance> perfs, List<Performance> expectedPerfs) {
    expect(perfs.map((e) => e.id), expectedPerfs.map((e) => e.id));
    expect(perfs.map((e) => e.dateTime.millisecondsSinceEpoch), expectedPerfs.map((e) => e.dateTime.millisecondsSinceEpoch));
    
    expect(perfs.map((e) => e.score.tempo), expectedPerfs.map((e) => e.score.tempo));
    expect(perfs.map((e) => e.score.bodyMovement), expectedPerfs.map((e) => e.score.bodyMovement));
    expect(perfs.map((e) => e.score.tracing), expectedPerfs.map((e) => e.score.tracing));
    expect(perfs.map((e) => e.score.hairBrushes), expectedPerfs.map((e) => e.score.hairBrushes));
    expect(perfs.map((e) => e.score.blocks), expectedPerfs.map((e) => e.score.blocks));
    expect(perfs.map((e) => e.score.locks), expectedPerfs.map((e) => e.score.locks));
    expect(perfs.map((e) => e.score.handToss), expectedPerfs.map((e) => e.score.handToss));
  }

  test('Read with no performance', () async {
    var sut = SharedPreferencesPerformanceRepository();

    var perfs = await sut.all();

    _assert(perfs, []);
  });

  test('Read with one performance', () async {
    var sut = SharedPreferencesPerformanceRepository();

    var score = PerformanceScore(1, 2, 3, 1, 2, 3, 1);
    var performance = Performance(0, score, DateTime.now());
    bool status = await sut.add(performance);

    expect(status, true);
    
    var perfs = await sut.all();
    var expectedPerfs = [performance];

    _assert(perfs, expectedPerfs);
  });

  test('Read with two performances', () async {
    var sut = SharedPreferencesPerformanceRepository();

    var score = PerformanceScore(1, 2, 3, 1, 2, 3, 1);
    var performance = Performance(0, score, DateTime.now());
    bool status = await sut.add(performance);
    expect(status, true);

    var score2 = PerformanceScore(3, 2, 1, 3, 2, 1, 3);
    var performance2 = Performance(1, score2, DateTime.now());
    bool status2 = await sut.add(performance2);
    expect(status2, true);
    
    var perfs = await sut.all();
    var expectedPerfs = [performance, performance2];

    _assert(perfs, expectedPerfs);
  });

}


