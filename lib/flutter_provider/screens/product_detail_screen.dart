import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_provider/provider/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  //
  // const ProductDetailScreen({Key key, this.title}) : super(key: key);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final selectedProduct =
        Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300,
            child: Image.network(
              selectedProduct.imageUrl,
              fit: BoxFit.scaleDown,
            ),
          ),
          SizedBox(height: 4,),
          Text('\$${selectedProduct.price}', style: TextStyle(color: Colors.grey, fontSize: 20),),
          SizedBox(height: 10,),
          Text("${selectedProduct.description}")
        ]),
      ),
    );
  }
}
