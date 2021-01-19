import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_redux/screens/login_screen.dart';
import 'package:flutter_app_state_management/flutter_redux/screens/register_screen.dart';

import 'screens/products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.indigo,
        fontFamily: 'Lato',
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: RegisterScreen(),
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        ProductsScreen.routeName: (context) => ProductsScreen()
      },
    );
  }
}
