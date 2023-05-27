import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'product.dart';

class ProductProvider with ChangeNotifier {
  final productCollection = FirebaseFirestore.instance.collection('products');

  final _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  Future<void> getProduct() async {
    final data = await productCollection.get();

    for (var i = 0; i < data.docs.length; i++) {
      Product product = Product.fromJson(data.docs[i].data());
      _items.add(product);
    }
    // for (var document in data.docs) {
    //   Product product = Product.fromJson(document.data());
    //   _items.add(product);
    // }
  
  }

  bool _showFavoritesOnly = false;

  final List<Product> favoriteItems = [];

  List get item {
    if (_showFavoritesOnly) {
      return _items.where((element) => element.isFavorite == true).toList();
    } else {
      return [..._items];
    }
  }

  // List get favoriteItems {
  //   return _items.where((element) => element.isFavorite == true).toList();
  // }

  bool select(Product pr) {
    // notifyListeners();
    return favoriteItems.contains(pr);
  }

  void addRmFV(Product pr) {
    if (select(pr)) {
      favoriteItems.remove(pr);
    } else {
      favoriteItems.add(pr);
    }
  }

  void showFavoritesOnly() {
    _showFavoritesOnly = true;
    // notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    // notifyListeners();
  }

  Product getById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addProdcut(Product product) {
    _items.add(product);
  }

  Future addProductData() async {
    for (var element in _items) {
      productCollection.add(element.toJson());
    }
  }
}
