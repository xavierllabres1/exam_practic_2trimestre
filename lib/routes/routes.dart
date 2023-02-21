import 'package:flutter/material.dart';

import '../screens/screens.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    'login': (_) => LoginScreen(),
    'home': (_) => HomeScreen(),
    'show': (_) => ShowScreen(),
    'plus': (_) => PlusScreen()
  };
}
