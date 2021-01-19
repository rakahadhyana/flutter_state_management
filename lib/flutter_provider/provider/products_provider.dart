import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_provider/provider/product_provider.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
        id: "1",
        title: "16-inch MacBook Pro",
        description: "16\" 6C (2.6GHz, 16GB, 512GB, 5300M) Gray",
        price: 2399,
        imageUrl: "https://photos5.appleinsider.com/price_guide/2019-macbook-pro-16-inch-pg-header.png"
    ),
    Product(
        id: "2",
        title: "13-inch MacBook Air",
        description: "MacBook Air (M1, 8GB, 256GB, 7-core GPU) Space Gray",
        price: 999,
        imageUrl: "https://photos5.appleinsider.com/price_guide/macbook-air-late-2020-pg-header.png"
    ),
    Product(
        id: "3",
        title: "27-inch iMac with Retina 5K display",
        description: "27\" iMac 6C (3.1, 8GB, 256GB, 5300)",
        price: 1799,
        imageUrl: "https://photos5.appleinsider.com/price_guide/27-inch-imac-2020-header.png"
    ),
    Product(
        id: "4",
        title: "iPhone 12",
        description: "64GB Black iPhone 12",
        price: 829,
        imageUrl: "https://photos5.appleinsider.com/price_guide/iphone-12-pg-header.png"
    )
  ];

  // var _showFavoritesOnly = false;
  //
  // void showFavoritesOnly(){
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }
  //
  // void showAll(){
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  List<Product> get items {
    // if(_showFavoritesOnly){
    //   return _items.where((element) => element.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addProduct() {
    notifyListeners();
  }
}