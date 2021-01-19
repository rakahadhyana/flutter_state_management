import 'package:flutter_app_state_management/flutter_redux/model/user.dart';
import 'package:flutter_app_state_management/flutter_redux/redux/actions.dart';
import 'package:flutter_app_state_management/flutter_redux/store/app_state.dart';

appReducer(state, action){
  print('state: ${state.toString()}, action: ${action.toString()}');
  return AppState(user: userReducer(state.user, action));
}

User userReducer(User user, action) {
  if(action is GetUserAction){
    return action.user;
  }
  return user;
}