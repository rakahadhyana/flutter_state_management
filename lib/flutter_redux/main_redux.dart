import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_redux/redux/actions.dart';
import 'package:flutter_app_state_management/flutter_redux/redux/reducers.dart';
import 'package:flutter_app_state_management/flutter_redux/screens/login_screen.dart';
import 'package:flutter_app_state_management/flutter_redux/screens/register_screen.dart';
import 'package:flutter_app_state_management/flutter_redux/store/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'screens/products_screen.dart';

void main() {
  final store = Store<AppState>((state, action) => appReducer(state, action),
      initialState: AppState.initial(), middleware: [thunkMiddleware]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.indigo,
            fontFamily: 'Lato',
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: RegisterScreen(),
        routes: {
          RegisterScreen.routeName: (context) => RegisterScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          ProductsScreen.routeName: (context) => ProductsScreen(
                onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                },
              )
        },
      ),
    );
  }
}
