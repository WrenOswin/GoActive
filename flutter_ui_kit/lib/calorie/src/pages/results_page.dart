import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fitness_ui_kit/calorie/src/widgets/result_tile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ResultPage extends StatelessWidget {
  ResultPage({
    required this.totalCalories,
    required this.carbs,
    required this.protein,
    required this.fats,
    required this.bmi,
    required this.tdee,
    required this.bmiScale,
  });

  final double totalCalories;
  final double carbs;
  final double protein;
  final double fats;
  final double bmi;
  final double tdee;
  final String bmiScale;

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        leading: IconButton(
          icon: Icon(EvaIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(6.0),
          children: [
            Screenshot(
              controller: screenshotController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ResultTile(
                    title: "Total Calories",
                    value: "${totalCalories.toStringAsFixed(0)}",
                    units: "KCALS",
                  ),
                  ResultTile(
                    title: "Carbs",
                    value: "${carbs.toStringAsFixed(0)}",
                    units: "GRAMS",
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ResultTile(
                          title: "Protein",
                          value: "${protein.toStringAsFixed(0)}",
                          units: "GRAMS",
                        ),
                      ),
                      Expanded(
                        child: ResultTile(
                          title: "Fats",
                          value: "${fats.toStringAsFixed(0)}",
                          units: "GRAMS",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ResultTile(
                          title: "BMI",
                          value: "${bmi.toStringAsFixed(1)}",
                          units: bmiScale,
                        ),
                      ),
                      Expanded(
                        child: ResultTile(
                          title: "TDEE",
                          value: "${tdee.toStringAsFixed(0)}",
                          units: "KCALS",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        tooltip: 'share',
        child: Icon(Icons.share_rounded),
        onPressed: () => shareScreenshot(screenshotController),
      ),
    );
  }

  void shareScreenshot(ScreenshotController key) async {
    var unit8List = await key.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/img.png');
    await file.writeAsBytes(unit8List!);
    await Share.shareFiles(
      [file.path],
      text: 'Calculated from Macro Calculator.\n' +
          'download now: https://play.google.com/store/apps/details?id=com.varadgauthankar.macro_calculator',
    );
  }
}
