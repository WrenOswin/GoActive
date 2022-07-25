import 'package:flutter/material.dart';

class CalTrak extends StatefulWidget {
  CalTrak();

  @override
  State<StatefulWidget> createState() {
    return _CalTrakState();
  }
}

class _CalTrakState extends State<CalTrak> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isBack = true;
  @override
  void initState() {
    super.initState();
  }

  void onClickBackButton() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calorie Tracking",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
