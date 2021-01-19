import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_item.dart';
import '../provider/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavorites;

  const ProductsGrid({Key key, @required this.showOnlyFavorites})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final loadedProducts = showOnlyFavorites
        ? productsProvider.favoriteItems
        : productsProvider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: loadedProducts[index],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
