import 'package:fitness_ui_kit/authenthication_service.dart';
import 'package:fitness_ui_kit/calorie/calmain.dart';
import 'package:fitness_ui_kit/charts/waterchart.dart';
import 'package:fitness_ui_kit/medicine/medicineapp.dart';
import 'package:fitness_ui_kit/medicine/screens/home/home.dart';
import 'package:fitness_ui_kit/pages/pedometer.dart';
import 'package:fitness_ui_kit/pages/pulse.dart';
import 'package:fitness_ui_kit/theme/colors.dart';
import 'package:fitness_ui_kit/water/water.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

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
  var dbcups = FirebaseFirestore.instance.collection("Cups");
  var dbbmi = FirebaseFirestore.instance.collection("BMI");
  void calculateBMI() {
    double height = double.parse(_heightController.text) / 100;
    weight = double.parse(_weightController.text);
    heightSquare = height * height;
    setState(() {
      _result = (weight! / heightSquare!);
    });
    dbbmi.doc("SCxXRadmGCxin5WYzlru").set({"bmi": _result});
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: thirdColor),
                    onPressed: () {
                      context.read<AuthenticationService>().signOut();
                    },
                    child: Text("Sign out"),
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
              SizedBox(
                height: 15,
              ),
              Center(
                child: Column(
                  children: [
                    Row(children: [
                      Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(28),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Pedometer()));
                          }, // Handle your callback.
                          splashColor: Colors.green,
                          child: Ink(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/Step.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(28),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Pulse()));
                          }, // Handle your callback.
                          splashColor: Colors.green,
                          child: Ink(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/heart.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    Row(children: [
                      Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(28),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Water()));
                          }, // Handle your callback.
                          splashColor: Colors.green,
                          child: Ink(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/waterbottle.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(28),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedicineApp()));
                          }, // Handle your callback.
                          splashColor: Colors.green,
                          child: Ink(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/medicine.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 15,
                    ),
                    Material(
                      elevation: 8,
                      borderRadius: BorderRadius.circular(28),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CalorieTrackerApp()));
                        }, // Handle your callback.
                        splashColor: Colors.green,
                        child: Ink(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/burger.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
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
