import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fitness_ui_kit/water/bloc/water_bloc.dart';
import 'package:fitness_ui_kit/water/domain/repository/water_repository.dart';
import 'package:fitness_ui_kit/water/ui/home/home_page.dart';
import 'package:fitness_ui_kit/water/ui/theme/app_theme.dart';
import 'package:path/path.dart';


Future<void> main() async {
  runApp(Water());
}

class Water extends StatefulWidget {
  @override
  _WaterState createState() => _WaterState();
}

class _WaterState extends State<Water> {
  final _repository = WaterRepository();

  @override
  void initState() {
    super.initState();
    _repository.subscribeToDataStore();
  }

  @override
  void dispose() {
    _repository.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (Context) => WaterBloc(_repository),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Water Reminder',
        theme: AppTheme.light,
        home: AnnotatedRegion(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: HomePage2(),
        ),
      ),
    );
  }
}
