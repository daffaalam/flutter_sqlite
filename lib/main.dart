import 'package:flutter/material.dart';
import 'package:flutter_sqlite/db_helper.dart';
import 'package:flutter_sqlite/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // create and initialize database
    DBHelper.createDatabase();
    return MaterialApp(
      home: HomePage(),
    );
  }
}
