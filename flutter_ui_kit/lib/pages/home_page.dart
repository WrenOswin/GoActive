import 'package:fitness_ui_kit/charts/waterchart.dart';
import 'package:fitness_ui_kit/pages/pedometer.dart';
import 'package:fitness_ui_kit/pages/pulse.dart';
import 'package:fitness_ui_kit/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double? _result;
  double? difference;
  double? heightSquare;
  double? weight;
  int cups = 0;
  void calculateBMI() {
    double height = double.parse(_heightController.text) / 100;
    weight = double.parse(_weightController.text);
    heightSquare = height * height;
    setState(() {
      _result = (weight! / heightSquare!);
    });

    if (_result! >= 25)
      calculateDiff(24.8);
    else if (_result! <= 18.4) calculateDiff(18.6);
  }

  void calculateDiff(double r) {
    difference = (r * heightSquare!) - weight!;
    difference = difference?.abs();
  }

  void incrementCups() {
    setState(() {
      if (cups < 13) cups += 1;
    });
  }

  void decrementCups() {
    setState(() {
      if (cups > 0) cups -= 1;
    });
  }

  Widget getBMItext() {
    if (_result == null)
      return Text("");
    else if (_result! < 18.5)
      return Text(
        "You are Underweight, need to gain ${difference?.toStringAsFixed(2)} kg to reach Optimal range",
        style:
            TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: white),
      );
    else if (_result! >= 18.5 && _result! <= 24.9)
      return Text(
        "You have Optimal BMI",
        style:
            TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: white),
      );
    else if (_result! >= 25 && _result! <= 29.9)
      return Text(
        "You are Overweight, need to lose ${difference?.toStringAsFixed(2)} kg to reach Optimal range",
        style:
            TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: white),
      );
    else
      return Text(
        "You are Obese, need to lose ${difference?.toStringAsFixed(2)} kg to reach Optimal range",
        style:
            TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: white),
      );
  }

  Widget getWatertext() {
    if (cups == 13)
      return Text("DAILY GOAL REACHED!",
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: white));
    else
      return Text(" ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(fontSize: 14, color: black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "User",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: black.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Icon(LineIcons.bell),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: [secondary, primary]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          width: (size.width),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "BMI (Body Mass Index)",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: white),
                              ),
                              getBMItext(),
                              TextField(
                                  controller: _heightController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Height in cm',
                                    contentPadding: EdgeInsets.all(10),
                                  )),
                              TextField(
                                controller: _weightController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Weight in kg',
                                  hintStyle: TextStyle(color: Colors.white),
                                  contentPadding: EdgeInsets.all(10),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: thirdColor),
                                child: const Text(
                                  "Calculate",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: calculateBMI,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: thirdColor,
                        ),
                        child: Center(
                          child: Text(
                            _result == null
                                ? "--"
                                : "${_result?.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: [secondary, primary]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          width: (size.width),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Water Intake (13 cups(250ml) minimum per day)",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: white),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          primary: thirdColor,
                                          padding: const EdgeInsets.all(30)),
                                      child: const Text(
                                        "-",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: decrementCups,
                                    ),
                                    Image.asset(
                                      'assets/images/water.png',
                                      height: 110,
                                      width: 110,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          primary: thirdColor,
                                          padding: const EdgeInsets.all(30)),
                                      child: const Text(
                                        "+",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: incrementCups,
                                    ),
                                  ]),
                              Container(
                                  alignment: Alignment.topCenter,
                                  margin: EdgeInsets.all(20),
                                  child: LinearProgressIndicator(
                                    value: cups / 13,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            thirdColor),
                                    minHeight: 10,
                                    backgroundColor: white,
                                  )),
                              Center(
                                child: Text(
                                  '$cups out of 13',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: white),
                                ),
                              ),
                              Center(
                                child: getWatertext(),
                              ),
                              BarChartSample3(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: thirdColor,
                        minimumSize: const Size(200, 50),
                        maximumSize: const Size(200, 50),
                      ),
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Pedometer()));
                      }),
                      child: Text("Track Steps"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: thirdColor,
                        minimumSize: const Size(200, 50),
                        maximumSize: const Size(200, 50),
                      ),
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Pulse()));
                      }),
                      child: Text("Pulse Rate"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: thirdColor,
                        minimumSize: const Size(200, 50),
                        maximumSize: const Size(200, 50),
                      ),
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Pulse()));
                      }),
                      child: Text("Diet"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: thirdColor,
                        minimumSize: const Size(200, 50),
                        maximumSize: const Size(200, 50),
                      ),
                      onPressed: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Pulse()));
                      }),
                      child: Text("Pills"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
