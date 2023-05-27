import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';

import '../models/products_provider.dart';

class SecondScreen extends StatelessWidget {
  String id;
  SecondScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context, listen: false);

    final selectedProduct = productData.getById(id);
    // Product selectedProduct = products.firstWhere(
    //   (element) => element.id == id,
    // );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 38),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                selectedProduct.title,
                style: TextStyle(fontSize: 40),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 350,
              width: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  selectedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              selectedProduct.description,
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$ ${selectedProduct.price}',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  width: 25,
                ),
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      'Buy Now',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
