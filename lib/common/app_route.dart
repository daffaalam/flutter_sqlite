import 'package:flutter/widgets.dart';

import '../ui/detail/detail_page.dart';
import '../ui/home/home_page.dart';

class AppRoute {
  static const String home = '/home';
  static const String detail = '/detail';
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    home: (BuildContext context) {
      return const HomePage();
    },
    detail: (BuildContext context) {
      return const DetailPage();
    },
  };
}
