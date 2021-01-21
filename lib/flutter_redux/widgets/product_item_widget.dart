import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_redux/model/product.dart';

class ProductItemWidget extends StatelessWidget {
  final Product item;

  const ProductItemWidget({this.item});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white,
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed(
              //   ProductDetailScreen.routeName,
              //   arguments: product.id
              // );
              print('onTap');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
          header: GridTileBar(
              title: Text(
            item.title,
            style: TextStyle(color: Colors.black, fontSize: 14),
            textAlign: TextAlign.center,
          )),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(Icons.favorite),
              color: Theme.of(context).accentColor,
              onPressed: () {
                print('onPressed');
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                // cart.addItem(product.id, product.title, product.price);
                print('onPressed');
              },
            ),
            subtitle: Text(
              '\$${item.price}',
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
