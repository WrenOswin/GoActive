import 'dart:math';

import 'package:fitness_ui_kit/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pedometer extends StatefulWidget {
  const Pedometer({Key? key}) : super(key: key);

  @override
  _PedometerState createState() => _PedometerState();
}

class _PedometerState extends State<Pedometer> {
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  double miles = 0.0;
  double duration = 0.0;
  double calories = 0.0;
  double addValue = 0.025;
  int steps = 0;
  double previousDistacne = 0.0;
  double distance = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AccelerometerEvent>(
        stream: SensorsPlatform.instance.accelerometerEvents,
        builder: (context, snapShort) {
          if (snapShort.hasData) {
            x = snapShort.data!.x;
            y = snapShort.data!.y;
            z = snapShort.data!.z;
            distance = getValue(x, y, z);
            if (distance > 6) {
              steps++;
            }
            calories = calculateCalories(steps);
            duration = calculateDuration(steps);
            miles = calculateMiles(steps);
          }
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      primary,
                      secondary,
                    ])),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SizedBox(
                        height: kToolbarHeight,
                      ),
                      Text(
                        'Steps taken: ',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),

                      Text(
                        steps.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                          ),
                          Text(
                            'Miles: ',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            miles.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            'Duration: ',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            duration.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            'Calories: ',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            calories.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),

                      // dashboard card
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  double getValue(double x, double y, double z) {
    double magnitude = sqrt(x * x + y * y + z * z);
    getPreviousValue();
    double modDistance = magnitude - previousDistacne;
    setPreviousValue(magnitude);
    return modDistance;
  }

  void setPreviousValue(double distance) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setDouble("preValue", distance);
  }

  void getPreviousValue() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      previousDistacne = _pref.getDouble("preValue") ?? 0.0;
    });
  }

  // void calculate data
  double calculateMiles(int steps) {
    double milesValue = (2.2 * steps) / 5280;
    return milesValue;
  }

  double calculateDuration(int steps) {
    double durationValue = (steps * 1 / 1000);
    return durationValue;
  }

  double calculateCalories(int steps) {
    double caloriesValue = (steps * 0.0566);
    return caloriesValue;
  }
}
