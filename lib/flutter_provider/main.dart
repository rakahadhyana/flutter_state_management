import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/cart_provider.dart';
import 'provider/orders_provider.dart';
import 'provider/products_provider.dart';
import 'screens/cart_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ProductsProvider()
        ),
        ChangeNotifierProvider(
            create: (context) => Cart()
        ),
        ChangeNotifierProvider(
            create: (context) => OrdersProvider()
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.indigo,
          fontFamily: 'Lato',
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen()
        },
      ),
    );
  }
}