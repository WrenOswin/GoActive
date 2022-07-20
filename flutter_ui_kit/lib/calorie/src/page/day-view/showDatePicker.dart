import 'package:flutter/material.dart';

class ShowDatePicker extends StatefulWidget {
  @override
  _ShowDatePicker createState() => _ShowDatePicker();
}

class _ShowDatePicker extends State<ShowDatePicker> {
  Color _rightArrowColor = const Color(0xffC1C1C1);
  Color _leftArrowColor = const Color(0xffC1C1C1);
  DateTime _value = DateTime.now();
  DateTime today = DateTime.now();

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _value,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color(0xff5FA55A), //Head background
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _value = picked);
    _stateSetter();
  }

  void _stateSetter() {
    if (today.difference(_value).compareTo(const Duration(days: 1)) == -1) {
      setState(() => _rightArrowColor = const Color(0xffEDEDED));
    } else {
      setState(() => _rightArrowColor = Colors.white);
    }
  }

  String _dateFormatter(DateTime tm) {
    DateTime today = DateTime.now();
    Duration oneDay = Duration(days: 1);
    Duration twoDay = Duration(days: 2);
    String month;

    switch (tm.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Feb";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Apr";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "Jun";
        break;
      case 7:
        month = "Jul";
        break;
      case 8:
        month = "Aug";
        break;
      case 9:
        month = "Sep";
        break;
      case 10:
        month = "Oct";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dec";
        break;
      default:
        month = "Undefined";
        break;
    }

    Duration difference = today.difference(tm);

    if (difference.compareTo(oneDay) < 1) {
      return "Today";
    } else if (difference.compareTo(twoDay) < 1) {
      return "Yesterday";
    } else {
      return "${tm.day} $month ${tm.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // width: 250,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: IconButton(
                key: const Key("left_arrow_button"),
                icon: const Icon(Icons.arrow_left, size: 25.0),
                color: _leftArrowColor,
                onPressed: () {
                  setState(() {
                    _value = _value.subtract(const Duration(days: 1));
                    _rightArrowColor = Colors.white;
                  });
                },
              ),
            ),
            Expanded(
              child: TextButton(
                // textColor: Colors.white,
                onPressed: () => _selectDate(),
                // },
                child: Text(_dateFormatter(_value),
                    style: const TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
            Expanded(
              child: IconButton(
                  key: const Key("right_arrow_button"),
                  icon: const Icon(Icons.arrow_right, size: 25.0),
                  color: _rightArrowColor,
                  onPressed: () {
                    if (today.difference(_value).compareTo(const Duration(days: 1)) ==
                        -1) {
                      setState(() {
                        _rightArrowColor = const Color(0xffC1C1C1);
                      });
                    } else {
                      setState(() {
                        _value = _value.add(const Duration(days: 1));
                      });
                      if (today
                              .difference(_value)
                              .compareTo(const Duration(days: 1)) ==
                          -1) {
                        setState(() {
                          _rightArrowColor = const Color(0xffC1C1C1);
                        });
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
