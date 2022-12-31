import 'package:flutter_test/flutter_test.dart';
// import 'package:fridge_cook/src/app/widgets/simple_bar_chart.dart';
import 'package:fridge_cook/src/domain/entities/performance.dart';
import 'package:fridge_cook/src/domain/entities/performance_score.dart';

void main() {

  // void _assertDays(Iterable days) {
  //   expect(days.length, 7);
  //   var expectedDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  //   for (var i = 0 ; i < expectedDays.length ; i++) {
  //     expect(days.elementAt(i), expectedDays[i]);
  //   }
  // }

  // test('For no performance, should display no performances', () {
  //   var sut = SimpleBarChart.withPerformances(StatsType.danceCount, DateTime.now(), []);

  //   var ordinalPerformances = sut.seriesList.first.data;
  //   var days = ordinalPerformances.map((e) => e.day);
  //   List<dynamic> performanceCounts = ordinalPerformances.map((e) => e.count).toList();

  //   _assertDays(days);
  //   for (var index = 0 ; index < days.length ; index++) {
  //     expect(performanceCounts[index], 0);
  //   }
  // });

  // test('For one 1 star-performance on Wednesday, should display performance', () {
  //   var wednesdayDateTime = DateTime(2020, DateTime.may, 13);
  //   var sut = SimpleBarChart.withPerformances(StatsType.danceCount, wednesdayDateTime, [
  //     Performance(0, PerformanceScore(1, 0, 0, 0, 0, 0, 0), wednesdayDateTime),
  //   ]);

  //   var ordinalPerformances = sut.seriesList.first.data;
  //   var days = ordinalPerformances.map((e) => e.day);
  //   List<dynamic> performanceCounts = ordinalPerformances.map((e) => e.count).toList();

  //   _assertDays(days);
  //   for (var index = 0 ; index < days.length ; index++) {
  //     expect(performanceCounts[index], index == 2 ? 1 : 0);
  //   }
  // });

  // test('For one 2-stars performance on Wednesday, should display dances', () {
  //   var wednesdayDateTime = DateTime(2020, DateTime.may, 13);
  //   var sut = SimpleBarChart.withPerformances(StatsType.danceCount, wednesdayDateTime, [
  //     Performance(0, PerformanceScore(1, 0, 1, 0, 0, 0, 0), wednesdayDateTime),
  //   ]);

  //   var ordinalPerformances = sut.seriesList.first.data;
  //   var days = ordinalPerformances.map((e) => e.day);
  //   List<dynamic> performanceCounts = ordinalPerformances.map((e) => e.count).toList();

  //   _assertDays(days);
  //   for (var index = 0 ; index < days.length ; index++) {
  //     expect(performanceCounts[index], index == 2 ? 1 : 0);
  //   }
  // });

  // test('For one 2-stars performance on Wednesday, should display performances', () {
  //   var wednesdayDateTime = DateTime(2020, DateTime.may, 13);
  //   var sut = SimpleBarChart.withPerformances(StatsType.starsCount, wednesdayDateTime, [
  //     Performance(0, PerformanceScore(1, 0, 1, 0, 0, 0, 0), wednesdayDateTime),
  //   ]);

  //   var ordinalPerformances = sut.seriesList.first.data;
  //   var days = ordinalPerformances.map((e) => e.day);
  //   List<dynamic> performanceCounts = ordinalPerformances.map((e) => e.count).toList();

  //   _assertDays(days);
  //   for (var index = 0 ; index < days.length ; index++) {
  //     expect(performanceCounts[index], index == 2 ? 2 : 0);
  //   }
  // });

  // test('For one performance on Wednesday and one on Friday, should display performances', () {
  //   var wednesdayDateTime = DateTime(2020, DateTime.may, 13);
  //   var fridayDateTime = DateTime(2020, DateTime.may, 15);
  //   var sut = SimpleBarChart.withPerformances(StatsType.danceCount, wednesdayDateTime, [
  //     Performance(0, PerformanceScore(1, 0, 0, 0, 0, 0, 0), wednesdayDateTime),
  //     Performance(0, PerformanceScore(1, 0, 0, 0, 0, 0, 0), fridayDateTime),
  //   ]);

  //   var ordinalPerformances = sut.seriesList.first.data;
  //   var days = ordinalPerformances.map((e) => e.day);
  //   List<dynamic> performanceCounts = ordinalPerformances.map((e) => e.count).toList();

  //   _assertDays(days);
  //   for (var index = 0 ; index < days.length ; index++) {
  //     expect(performanceCounts[index], index == 2 || index == 4 ? 1 : 0);
  //   }
  // });

  // test('For one performance on last Sunday and one new on Monday, should display only current week performances', () {
  //   var sundayDateTime = DateTime(2020, DateTime.may, 10);
  //   var mondayDateTime = DateTime(2020, DateTime.may, 11, 19);
  //   var currentDateTime = DateTime(2020, DateTime.may, 11);
  //   var sut = SimpleBarChart.withPerformances(StatsType.starsCount, currentDateTime, [
  //     Performance(0, PerformanceScore(1, 0, 0, 0, 0, 0, 0), sundayDateTime),
  //     Performance(0, PerformanceScore(1, 0, 0, 0, 0, 0, 0), mondayDateTime),
  //   ]);

  //   var ordinalPerformances = sut.seriesList.first.data;
  //   var days = ordinalPerformances.map((e) => e.day);
  //   List<dynamic> performanceCounts = ordinalPerformances.map((e) => e.count).toList();

  //   _assertDays(days);
  //   for (var index = 0 ; index < days.length ; index++) {
  //     var expectedCount = 0;
  //     if (index == 0)
  //       expectedCount = 1;
  //     expect(performanceCounts[index], expectedCount);
  //   }
  // });

  // test('For stars count type, should display stars count correctly', () {
  //   var wednesdayDateTime = DateTime(2020, DateTime.may, 13);
  //   var fridayDateTime = DateTime(2020, DateTime.may, 15);
  //   var sut = SimpleBarChart.withPerformances(StatsType.starsCount, wednesdayDateTime, [
  //     Performance(0, PerformanceScore(1, 0, 0, 3, 0, 0, 0), wednesdayDateTime),
  //     Performance(0, PerformanceScore(1, 0, 0, 0, 3, 0, 0), fridayDateTime),
  //   ]);

  //   var ordinalPerformances = sut.seriesList.first.data;
  //   var days = ordinalPerformances.map((e) => e.day);
  //   List<dynamic> performanceCounts = ordinalPerformances.map((e) => e.count).toList();

  //   _assertDays(days);
  //   for (var index = 0 ; index < days.length ; index++) {
  //     expect(performanceCounts[index], index == 2 || index == 4 ? 4 : 0);
  //   }
  // });

}
