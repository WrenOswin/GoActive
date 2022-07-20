import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fitness_ui_kit/calorie/src/services/database.dart';
import 'package:fitness_ui_kit/calorie/src/model/food-track-entry.dart';

class DateTimeChart extends StatefulWidget {
  const DateTimeChart({Key? key}) : super(key: key);

  @override
  _DateTimeChart createState() => _DateTimeChart();
}

class _DateTimeChart extends State<DateTimeChart> {
  List<charts.Series<FoodTrackEntry, DateTime>>? resultChartData = null;
  DatabaseService databaseService = DatabaseService(
      uid: "calorie-tracker-b7d17", currentDate: DateTime.now());

  @override
  void initState() {
    super.initState();

    getAllFoodTrackData();
  }

  void getAllFoodTrackData() async {
    List<dynamic> foodTrackResults =
        await databaseService.getAllFoodTrackData();
    List<FoodTrackEntry> foodTrackEntries = [];

    for (var foodTrack in foodTrackResults) {
      if (foodTrack["createdOn"] != null) {
        foodTrackEntries.add(FoodTrackEntry(
            foodTrack["createdOn"].toDate(), foodTrack["calories"]));
      }
    }
    populateChartWithEntries(foodTrackEntries);
  }

  void populateChartWithEntries(List<FoodTrackEntry> foodTrackEntries) async {
    Map<String, int> caloriesByDateMap = {};
    if (foodTrackEntries != null) {
      var dateFormat = DateFormat("yyyy-MM-dd");
      for (var foodEntry in foodTrackEntries) {
        var trackedDateStr = foodEntry.date;
        var trackedDate = dateFormat.format(trackedDateStr);
        if (caloriesByDateMap.containsKey(trackedDate)) {
          caloriesByDateMap[trackedDate] =
              caloriesByDateMap[trackedDate]! + foodEntry.calories;
        } else {
          caloriesByDateMap[trackedDate] = foodEntry.calories;
        }
      }
      List<FoodTrackEntry> caloriesByDateTimeMap = [];
      for (var foodEntry in caloriesByDateMap.keys) {
        DateTime entryDateTime = DateTime.parse(foodEntry);
        caloriesByDateTimeMap.add(
            FoodTrackEntry(entryDateTime, caloriesByDateMap[foodEntry]!));
      }

      caloriesByDateTimeMap.sort((a, b) {
        int aDate = a.date.microsecondsSinceEpoch;
        int bDate = b.date.microsecondsSinceEpoch;

        return aDate.compareTo(bDate);
      });
      setState(() {
        resultChartData = [
          charts.Series<FoodTrackEntry, DateTime>(
              id: "Food Track Entries",
              colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
              domainFn: (FoodTrackEntry foodTrackEntry, _) =>
                  foodTrackEntry.date,
              measureFn: (FoodTrackEntry foodTrackEntry, _) =>
                  foodTrackEntry.calories,
              labelAccessorFn: (FoodTrackEntry foodTrackEntry, _) =>
                  '${foodTrackEntry.date}: ${foodTrackEntry.calories}',
              data: caloriesByDateTimeMap)
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (resultChartData != null) {
      return Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Caloric Intake By Date Chart"),
            Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  height: 300.0,
                  child:
                      charts.TimeSeriesChart(resultChartData!, animate: true),
                ))
          ],
        )),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
