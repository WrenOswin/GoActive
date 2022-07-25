import 'package:flutter/material.dart';

import 'package:fitness_ui_kit/calorie/src/utils/textStyles.dart';
import 'package:fitness_ui_kit/calorie/src/widgets/tile.dart';

class ResultTile extends StatelessWidget {
  const ResultTile({
    Key? key,
    required this.title,
    required this.value,
    required this.units,
  }) : super(key: key);

  final String title;
  final String value;
  final String units;

  @override
  Widget build(BuildContext context) {
    return Tile(
      child: Column(
        children: [
          Text(value, style: MyTextStyles(context).resultCardValue),
          Text(units, style: MyTextStyles(context).resultCardUnit),
          Text(title, style: MyTextStyles(context).resultCardText),
        ],
      ),
    );
  }
}
