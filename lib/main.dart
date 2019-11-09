import 'package:flutter/material.dart';

import 'splash.dart';

main() {
  runApp(
    EudekaApp(),
  );
}

class EudekaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
    );
  }
}
