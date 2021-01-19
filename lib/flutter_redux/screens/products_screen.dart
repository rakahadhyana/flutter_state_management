import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_redux/redux/actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../store/app_state.dart';

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
    StoreProvider.of<AppState>(context).dispatch(getUserAction);
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
          body: Text('Products Page'),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // widget.onInit();
  }
}
