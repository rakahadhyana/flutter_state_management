import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductsScreen extends StatefulWidget {
  static const routeName = "/products";

  @override
  _ProductsScreenState createState() {
    return _ProductsScreenState();
  }
}

class _ProductsScreenState extends State<ProductsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products"),),
    );
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async{
    final prefs = await SharedPreferences.getInstance();
    var storedUser = prefs.getString('user');
    print(json.decode(storedUser));
  }
}