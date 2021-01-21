import 'package:flutter/foundation.dart';
import 'package:flutter_app_state_management/flutter_redux/model/product.dart';
import 'package:flutter_app_state_management/flutter_redux/model/user.dart';

@immutable
class AppState {
  final User user;
  final List<Product> products;

  AppState({ @required this.user, @required this.products });

  factory AppState.initial(){
    return AppState(user: null, products: []);
  }
}