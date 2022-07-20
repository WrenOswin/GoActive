
import 'package:fitness_ui_kit/calorie/src/page/day-view/day_view.dart';
import 'package:fitness_ui_kit/calorie/src/providers/theme_notifier.dart';
import 'package:fitness_ui_kit/calorie/src/services/shared_preference_service.dart';
import 'package:flutter/material.dart';
import 'src/page/history/history_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:fitness_ui_kit/calorie/helpers/theme.dart';
import 'package:fitness_ui_kit/calorie/routes/router.dart';


Future<void> main() async {
  runApp(const CalorieTrackerApp());
}

class CalorieTrackerApp extends StatefulWidget {
  const CalorieTrackerApp({Key? key}) : super(key: key);

  @override
  CalorieTrackerAppState createState() => CalorieTrackerAppState();
}

class CalorieTrackerAppState extends State<CalorieTrackerApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  late Widget homeWidget;
  late bool signedIn;

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  void checkFirstSeen() {
    const bool _firstLaunch = true;

    if (_firstLaunch) {
      homeWidget = const Homepag();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DarkThemeProvider>(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder:
            (BuildContext context, DarkThemeProvider value, Widget? child) {
          return GestureDetector(
              onTap: () => hideKeyboard(context),
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  builder: (_, Widget? child) => ScrollConfiguration(
                      behavior: MyBehavior(), child: child!),
                  theme: themeChangeProvider.darkTheme ? darkTheme : lightTheme,
                  home: homeWidget,
                  onGenerateRoute: RoutePage.generateRoute));
        },
      ),
    );
  }

  void hideKeyboard(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}

class Homepag extends StatefulWidget {
  const Homepag({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: () {
            // Navigate back to homepage
          },
          child: const Text('Go Back!'),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _Homepag();
  }
}

class _Homepag extends State<Homepag> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  void onClickHistoryScreenButton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HistoryScreen()));
  }

  void onClickDayViewScreenButton(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DayViewScreen()));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
            ),
            const ListTile(
                title: Text("Calorie Tracking",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold))),
            ElevatedButton(
                onPressed: () {
                  onClickDayViewScreenButton(context);
                },
                child: const Text("Day View Screen")),
            ElevatedButton(
                onPressed: () {
                  onClickHistoryScreenButton(context);
                },
                child: const Text("History Screen")),
          ],
        ));
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
