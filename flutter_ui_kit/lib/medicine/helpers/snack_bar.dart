import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Snackbar {
  late BuildContext context;

  void showSnack(String message, GlobalKey<ScaffoldState> _scaffoldKey,
          // ignore: non_constant_identifier_names
          Function? undo, Context) =>
      ScaffoldMessenger.of(Context).showSnackBar(
        SnackBar(
          content: Text(message),
          action: undo != null
              ? SnackBarAction(
                  textColor:
                      Theme.of(_scaffoldKey.currentState!.context).primaryColor,
                  label: "Undo",
                  onPressed: () => undo,
                )
              : null,
        ),
      );
}
