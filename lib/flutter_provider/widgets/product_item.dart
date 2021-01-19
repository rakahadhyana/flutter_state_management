import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_provider/provider/cart_provider.dart';
import 'package:flutter_app_state_management/flutter_provider/provider/product_provider.dart';
import 'package:flutter_app_state_management/flutter_provider/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.toggleFavoriteStatus();
              },
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(product.id, product.title, product.price);
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
