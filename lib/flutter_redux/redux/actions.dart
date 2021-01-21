import 'dart:convert';

import 'package:flutter_app_state_management/flutter_redux/model/product.dart';
import 'package:flutter_app_state_management/flutter_redux/store/app_state.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

/* User Actions */
ThunkAction<AppState> getUserAction = (Store<AppState> store) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String storedUser = prefs.getString('user');
  final user =
      storedUser != null ? User.fromJson(json.decode(storedUser)) : null;
  print('storedUser: $storedUser');

  store.dispatch(GetUserAction(user));
};

class GetUserAction {
  final User _user;

  GetUserAction(this._user);

  User get user => this._user;
}

/* Products Action */
ThunkAction<AppState> getProductsAction = (Store<AppState> store) async {
  http.Response response = await http.get('http://10.0.2.2:1337/products');
  final List<dynamic> responseData = json.decode(response.body);
  print('products: $responseData');
  final List<Product> products = responseData.isNotEmpty
      ? responseData.map((e) => Product.fromJson(e)).toList()
      : List.empty();
  store.dispatch(GetProductsAction(products));
};

class GetProductsAction {
  final List<Product> _products;

  GetProductsAction(this._products);

  List<Product> get products => this._products;
}
