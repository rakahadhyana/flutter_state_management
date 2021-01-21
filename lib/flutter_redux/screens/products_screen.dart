import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_redux/widgets/product_item_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../store/app_state.dart';

final gradientBackground = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        stops: [
      0.1,
      0.3,
      0.5,
      0.7,
      0.9
    ],
        colors: [
      Colors.grey[300],
      Colors.grey[400],
      Colors.grey[500],
      Colors.grey[600],
      Colors.grey[700]
    ]));

class ProductsScreen extends StatefulWidget {
  static const routeName = "/products";
  final Function() onInit;

  const ProductsScreen({this.onInit});

  @override
  _ProductsScreenState createState() {
    return _ProductsScreenState();
  }
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return StoreConnector<AppState, AppState>(
      converter: (Store<AppState> store) => store.state,
      builder: (context, state) {
        print("state: ${state.user.toString()}");
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: state.user != null ? Text(state.user.username) : Text(''),
            leading: Icon(Icons.store),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: state.user != null
                    ? IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () => print('onPressed'),
                      )
                    : Text(''),
              )
            ],
          ),
          body: Container(
            decoration: gradientBackground,
            child: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return Column(
                    children: [
                      Expanded(
                        child: SafeArea(
                          child: GridView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: state.products.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                                childAspectRatio: 2 / 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, i) =>
                                  ProductItemWidget(item: state.products[i])),
                        ),
                      )
                    ],
                  );
                }),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    widget.onInit();
  }
}
