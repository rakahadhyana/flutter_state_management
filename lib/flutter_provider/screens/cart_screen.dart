import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_provider/provider/cart_provider.dart';
import 'package:flutter_app_state_management/flutter_provider/provider/orders_provider.dart';
import 'package:flutter_app_state_management/flutter_provider/widgets/cart_item_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total",
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  Spacer(),
                  Chip(
                    label: Text('\$ ${cart.totalPrice.toString()}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .headline6
                                ?.color)),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: () {
                      Provider.of<OrdersProvider>(context, listen: false)
                          .addOrder(
                              cart.items.values.toList(), cart.totalPrice);
                      cart.clear();
                    },
                    child: Text("ORDER NOW"),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Consumer<Cart>(
              builder: (context, cart, child) => ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, position) => CartItemWidget(
                        id: cart.items.values.toList()[position].id,
                        price: cart.items.values.toList()[position].price,
                        quantity: cart.items.values.toList()[position].quantity,
                        title: cart.items.values.toList()[position].title,
                        productId: cart.items.keys.toList()[position],
                      )),
            ),
          )
        ],
      ),
    );
  }
}
