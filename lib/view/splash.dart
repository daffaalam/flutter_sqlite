import 'package:flutter/material.dart';

import '../config/constant.dart';
import '../database/database_helper.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    DatabaseHelper.createDatabase().then(
      (_) {
        Navigator.pushReplacementNamed(context, Constant.homeRoute);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
