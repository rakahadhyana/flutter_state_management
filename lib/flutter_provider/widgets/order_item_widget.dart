import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_provider/provider/orders_provider.dart';
import 'package:intl/intl.dart';

class OrderItemWidget extends StatefulWidget {
  final OrderItem orderItem;

  const OrderItemWidget({Key key, @required this.orderItem}) : super(key: key);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orderItem.amount}'),
            subtitle: Text(DateFormat("dd/MM/yyyy hh:mm")
                .format(widget.orderItem.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: min(
                  200, (widget.orderItem.products.length * 50 + 10).toDouble()),
              child: ListView(
                children: widget.orderItem.products
                    .map((product) => ListTile(
                          title: Text(
                            product.title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            softWrap: true,
                          ),
                          trailing: Text(
                            '${product.quantity} x \$${product.price}',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
