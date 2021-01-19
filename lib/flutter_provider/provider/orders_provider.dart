import 'package:flutter/foundation.dart';
import 'package:flutter_app_state_management/flutter_provider/provider/cart_provider.dart';

class OrderItem{
  final String orderId;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.orderId,
    @required this.amount,
    @required this.products,
    @required this.dateTime
  });

}

class OrdersProvider with ChangeNotifier{
  List<OrderItem> _orders = [];

  List<OrderItem> get orders{
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total){
    _orders.insert(0, OrderItem(
        orderId: DateTime.now().toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now()
    ));
    notifyListeners();
  }

  void clear(){
    _orders.clear();
    notifyListeners();
  }
}