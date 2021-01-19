import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_provider/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
              },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.update),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
        ],
      ),
    );
  }

}