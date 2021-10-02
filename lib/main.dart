import 'package:flutter/material.dart';

import 'common/app_route.dart';

main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRoute.routes,
      initialRoute: AppRoute.home,
    );
  }
}
