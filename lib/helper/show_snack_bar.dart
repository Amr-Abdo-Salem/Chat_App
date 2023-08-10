import 'package:flutter/material.dart';

// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
// ignore: non_constant_identifier_names
ShowSnackBar(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
