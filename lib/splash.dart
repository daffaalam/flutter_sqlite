import 'dart:async';

import 'package:flutter/material.dart';

import 'database_helper.dart';
import 'home.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DatabaseHelper.createDatabase();
    Duration _duration = Duration(
      seconds: 1,
    );
    Route _route = MaterialPageRoute(
      builder: (context) => HomePage(),
    );
    Timer(_duration, () {
      Navigator.pushReplacement(context, _route);
    });
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
