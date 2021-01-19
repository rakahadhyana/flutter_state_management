import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_provider/provider/orders_provider.dart';
import 'package:flutter_app_state_management/flutter_provider/widgets/app_drawer.dart';
import 'package:flutter_app_state_management/flutter_provider/widgets/order_item_widget.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget{
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (context, index) => OrderItemWidget(
          orderItem: ordersProvider.orders[index],
        )
      ),
    );
  }
}