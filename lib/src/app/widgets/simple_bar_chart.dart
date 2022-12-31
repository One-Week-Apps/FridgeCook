// /// Bar chart example
// //import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';
// import 'package:fridge_cook/src/domain/entities/performance.dart';

// enum StatsType {
//   danceCount,
//   starsCount
// }

// class SimpleBarChart extends StatelessWidget {
//   final List<charts.Series> seriesList;
//   final bool animate;

//   SimpleBarChart(this.seriesList, {this.animate});

//   /// Creates a [BarChart] with sample data and no transition.
//   factory SimpleBarChart.withSampleData() {
//     return new SimpleBarChart(
//       _createSampleData(),
//       // Disable animations for image tests.
//       animate: false,
//     );
//   }

//   factory SimpleBarChart.withPerformances(StatsType type, DateTime currentDateTime, List<Performance> performances) {
//     return new SimpleBarChart(
//       _createPerformancesData(type, currentDateTime, performances),
//       // Turning to true shows nothing on Simulator
//       animate: false,
//     );
//   }


//   @override
//   Widget build(BuildContext context) {
//     return new charts.BarChart(
//       seriesList,
//       animate: animate,
//     );
//   }
  
//   static List<String> weekDays(String localeName) {    
//     DateFormat formatter = DateFormat(DateFormat.WEEKDAY, localeName);
//     return [DateTime(2000, 1, 3, 1), DateTime(2000, 1, 4, 1), DateTime(2000, 1, 5, 1),
//       DateTime(2000, 1, 6, 1), DateTime(2000, 1, 7, 1), DateTime(2000, 1, 8, 1),
//       DateTime(2000, 1, 9, 1)].map((day) => formatter.format(day)).toList();
//   }

//   /// Create one series with provided performances data.
//   static List<charts.Series<OrdinalPerformances, String>> _createPerformancesData(StatsType type, DateTime currentDateTime, List<Performance> performances) {

//     var locale = "en_US";
//     initializeDateFormatting(locale);

//     if (performances.isEmpty) {
//       final data = [
//         new OrdinalPerformances('Mon', 0),
//         new OrdinalPerformances('Tue', 0),
//         new OrdinalPerformances('Wed', 0),
//         new OrdinalPerformances('Thu', 0),
//         new OrdinalPerformances('Fri', 0),
//         new OrdinalPerformances('Sat', 0),
//         new OrdinalPerformances('Sun', 0),
//       ];
//       return [
//         new charts.Series<OrdinalPerformances, String>(
//           id: 'Progress',
//           colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orange),
//           domainFn: (OrdinalPerformances performances, _) => performances.day,
//           measureFn: (OrdinalPerformances performances, _) => performances.count,
//           data: data,
//         )
//       ];
//     }

//     var data = <OrdinalPerformances>[];
//     var weekdaysString = weekDays(locale);
//     for (int day = DateTime.monday; day <= DateTime.sunday; day++) {
//       var weekdayString = weekdaysString[day - 1].substring(0, 3);
//       var count = type == StatsType.danceCount ? danceNumberFor(day, currentDateTime, performances) : starsNumberFor(day, currentDateTime, performances);
//       data.add(new OrdinalPerformances(weekdayString, count));
//     }

//     return [
//       new charts.Series<OrdinalPerformances, String>(
//         id: 'Progress',
//         colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orange),
//         domainFn: (OrdinalPerformances performances, _) => performances.day,
//         measureFn: (OrdinalPerformances performances, _) => performances.count,
//         data: data,
//       )
//     ];
//   }

//   static int danceNumberFor(int weekday, DateTime currentDateTime, List<Performance> performances) {
//     if (weekday < DateTime.monday || weekday > DateTime.sunday) return 0;

//     int danceNumber;

//     var weekDay = currentDateTime.weekday;
//     var firstDayOfWeek = currentDateTime.subtract(Duration(days: weekDay - 1));

//     try {
//       var performancesForDay = performances.where((element) => element.dateTime.weekday == weekday && element.dateTime.isAfter(firstDayOfWeek));
//       danceNumber = performancesForDay.length;
//     } catch (e) {
//       danceNumber = 0;
//     }
//     return danceNumber;
//   }

//   static int starsNumberFor(int weekday, DateTime currentDateTime, List<Performance> performances) {
//     if (weekday < DateTime.monday || weekday > DateTime.sunday) return 0;

//     int starsNumber;

//     var weekDay = currentDateTime.weekday;
//     var firstDayOfWeek = currentDateTime.subtract(Duration(days: weekDay - 1));

//     try {
//       var performancesForDay = performances.where((element) => element.dateTime.weekday == weekday && element.dateTime.isAfter(firstDayOfWeek));
//       var performancesForDayTotals = performancesForDay.map((e) => e.score.total);
//       starsNumber = performancesForDayTotals.reduce((value, element) => value + element);
//     } catch (e) {
//       starsNumber = 0;
//     }
//     return starsNumber;
//   }

//   /// Create one series with sample hard coded data.
//   static List<charts.Series<OrdinalPerformances, String>> _createSampleData() {
//     final data = [
//       new OrdinalPerformances('Mon', 2),
//       new OrdinalPerformances('Tue', 1),
//       new OrdinalPerformances('Wed', 0),
//       new OrdinalPerformances('Thu', 1),
//       new OrdinalPerformances('Fri', 2),
//       new OrdinalPerformances('Sat', 0),
//       new OrdinalPerformances('Sun', 3),
//     ];

//     return [
//       new charts.Series<OrdinalPerformances, String>(
//         id: 'Progress',
//         colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.orange),
//         domainFn: (OrdinalPerformances performances, _) => performances.day,
//         measureFn: (OrdinalPerformances performances, _) => performances.count,
//         data: data,
//       )
//     ];
//   }
// }

// /// Sample ordinal data type.
// class OrdinalPerformances {
//   final String day;
//   final int count;

//   OrdinalPerformances(this.day, this.count);
// }