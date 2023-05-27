import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/products_provider.dart';
import 'package:shop/models/user_class.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final productCollection = FirebaseFirestore.instance.collection('user2');
    final productData = Provider.of<ProductProvider>(context, listen: false);
  

    final myUser = {
      'name': 'Tigo',
      'age': 47,
      'hobby': 'qez hinch',
    };

    Future<void> adUSer() {
      print('ha');
      return usersCollection.add(myUser);
    }

    Future<void> getUsers() async {
      final QuerySnapshot<Map<String, dynamic>> data =
          await usersCollection.get();
      final myUsers = data.docs.map((e) => e.data()).toList();
      print(myUsers);
    }

    // final myProduct =
    //     Product(description: 'description', id: 'id', price: 4, title: 'title');

    // Future addProduct() async {
    //   return productCollection.add(myProduct.toJson());
    // }

    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 300,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: ((context, index) => Text('data')),
              ),
            ),
            TextButton(
                onPressed: (() {
                  productData.addProductData();
                }),
                child: const Text('vapshe karevorchi'))
          ],
        ),
      ),
    );
  }
}
