import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_provider/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget{
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productId;

  const CartItemWidget({Key key, @required this.id, @required this.price, @required this.quantity, @required this.title, @required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Padding(padding: EdgeInsets.symmetric(horizontal: 8),child: Text('\$ $price'))),
            ),
            title: Text(title),
            subtitle: Text('Total: \$ ${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}