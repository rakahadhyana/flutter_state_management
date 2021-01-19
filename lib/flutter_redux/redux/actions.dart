import 'dart:convert';

import 'package:flutter_app_state_management/flutter_redux/store/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
/* User Actions */
ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString('user');
  final user = storedUser != null ? User.fromJson(json.decode(storedUser)) : null;
  print('storedUser: $storedUser');

  store.dispatch(GetUserAction(user));
};

class GetUserAction {
  final User _user;

  GetUserAction(this._user);

  User get user => this._user;
}

