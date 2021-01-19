import 'package:flutter/foundation.dart';
import 'package:flutter_app_state_management/flutter_redux/model/user.dart';

@immutable
class AppState {
  final User user;

  AppState({ @required this.user });

  factory AppState.initial(){
    return AppState(user: null);
  }
}