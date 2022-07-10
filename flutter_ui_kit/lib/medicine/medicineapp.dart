
import 'package:flutter/material.dart';
import './screens/welcome/welcome.dart';
import 'screens/add_new_medicine/add_new_medicine.dart';
import 'screens/home/home.dart';

class MedicineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => Welcome(),
        "/home": (context) => Home(),
        "/add_new_medicine": (context) => AddNewMedicine(),
      },
      initialRoute: "/",
    );
  }
}
