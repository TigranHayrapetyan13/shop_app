import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/widgets/product_item.dart';

import '../models/products_provider.dart';

class ProductGrid extends StatelessWidget {
  bool showONlyFAvorites;

  ProductGrid({
    required this.showONlyFAvorites,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context, listen: false);
    final products =
        showONlyFAvorites ? productData.favoriteItems : productData.item;
    final productCollection = FirebaseFirestore.instance.collection('products');
    return StreamBuilder(
        stream: productCollection.snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 10),
              children: snapshot.data!.docs.map((document) {
                return ProductItem(
                  product: Product(document['likes'],
                      description: document['description'],
                      id: document['id'],
                      price: document['price'],
                      title: document['title'],
                      imageUrl: document['imageUrl']),
                );
              }).toList(),
            );
          }
        }));
  }
}
