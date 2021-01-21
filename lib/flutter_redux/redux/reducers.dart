import 'package:flutter_app_state_management/flutter_redux/model/product.dart';
import 'package:flutter_app_state_management/flutter_redux/model/user.dart';
import 'package:flutter_app_state_management/flutter_redux/redux/actions.dart';
import 'package:flutter_app_state_management/flutter_redux/store/app_state.dart';

appReducer(AppState state, action) {
  print('state: ${state.toString()}, action: ${action.toString()}');
  return AppState(
      user: userReducer(state.user, action),
      products: productsReducer(state.products, action));
}

User userReducer(User user, action) {
  if (action is GetUserAction) {
    return action.user;
  }
  return user;
}

dynamic productsReducer(List<Product> products, action) {
  if (action is GetProductsAction) {
    return action.products;
  }
  return products;
}
