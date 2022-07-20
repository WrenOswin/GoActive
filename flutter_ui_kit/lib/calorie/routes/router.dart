import 'package:flutter/cupertino.dart';
import 'route_constants.dart';
import 'package:fitness_ui_kit/calorie/views/undefined_view.dart';
import 'package:fitness_ui_kit/calorie/calmain.dart';

class RoutePage {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstant.ROOT:
        return PageRouteBuilder<dynamic>(
            settings: settings,
            pageBuilder: (_, __, ___) => const Homepag(),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));
      default:
        return PageRouteBuilder<dynamic>(
            settings: settings,
            pageBuilder: (_, __, ___) => UndefinedView(
                  routeName: settings.name!,
                ),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));
    }
  }
}
