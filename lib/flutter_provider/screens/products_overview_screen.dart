import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_provider/provider/cart_provider.dart';
import 'package:flutter_app_state_management/flutter_provider/screens/cart_screen.dart';
import 'package:flutter_app_state_management/flutter_provider/widgets/app_drawer.dart';
import 'package:flutter_app_state_management/flutter_provider/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All
}

class ProductsOverviewScreen extends StatefulWidget {

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              print(selectedValue);
              setState(() {
                if (selectedValue == FilterOptions.Favorites){
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(child: Text('Only Favorites'), value: FilterOptions.Favorites,),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All,)
            ],
          ),
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              toAnimate: false,
              position: BadgePosition.topEnd(top: 5, end: 5),
              badgeContent: Text(
                cart.itemCount.toString(),
                style: TextStyle(fontSize: 10),
              ),
              child: child,
            ),
            child: IconButton(
              onPressed: () => {
                Navigator.of(context).pushNamed(CartScreen.routeName)
              },
              icon: Icon(Icons.shopping_cart,)
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(
          showOnlyFavorites: _showOnlyFavorites,
      ),
    );
  }
}
