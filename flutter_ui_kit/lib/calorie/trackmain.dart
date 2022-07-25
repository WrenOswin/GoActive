import 'package:hive_flutter/hive_flutter.dart';
import 'package:fitness_ui_kit/calorie/src/controllers/data_controller.dart';
import 'package:fitness_ui_kit/calorie/src/controllers/theme_controller.dart';
import 'package:fitness_ui_kit/calorie/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fitness_ui_kit/calorie/src/utils/color_schemes.dart';
import 'package:provider/provider.dart';

class Hiveapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataController()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
      ],
      child: Consumer<ThemeController>(
        builder: (context, theme, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Macro Calculator',
            home: HomePage(),
            theme: ThemeData(
              scaffoldBackgroundColor: lightColorScheme.background,
              useMaterial3: true,
              colorScheme: lightColorScheme,
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: darkColorScheme.background,
              useMaterial3: true,
              colorScheme: darkColorScheme,
            ),
            themeMode: theme.themeMode,
          );
        },
      ),
    );
  }
}
