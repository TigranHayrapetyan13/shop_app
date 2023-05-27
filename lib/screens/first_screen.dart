import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop/main.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/products_provider.dart';
import 'package:shop/models/user_class.dart';
import 'package:shop/providers/auths.dart';
import 'package:shop/screens/add_product_screen.dart';
import 'package:shop/screens/basket_screen.dart';
import 'package:shop/screens/search_screen.dart';
import 'package:shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../providers/pasket_provider.dart';
import '../widgets/product_grid.dart';

enum FilterOptions { Favorites, All }

class FirstScreen extends StatefulWidget {
  const FirstScreen({
    super.key,
  });

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final authServices = FirebaseAuth.instance;
  bool _showOnlyyFavorites = false;

  @override
  Widget build(BuildContext context) {
    final authServices = FirebaseAuth.instance;
    final pasketData = Provider.of<Basket>(context);
    final authData = Provider.of<AuthProvider>(context);
    final user = authData.user;

    // final String user =   userCollection.doc('name') as String;

    // final user = UserName.fromJson(userCollection.data());

    final productData = Provider.of<ProductProvider>(
      context,
    );
    Provider.of<AuthProvider>(context)
        .getUserById(authServices.currentUser!.uid);

    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Row(
                  children: [
                    user == null
                        ? const SizedBox()
                        : Text(
                            user.name,
                          ),
                    user == null ? const SizedBox() : Text(user.name),
                  ],
                )
              ],
            ),
          ),
        ],
      )),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const SearchScreen()),
                  ),
                );
              },
              icon: const Icon(Icons.search)),
          Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Center(
                    child: Text(
                      '${pasketData.basket.length}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: (() {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const BasketPage())));
                  }),
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  )),
            ],
          ),
          PopupMenuButton(
            onSelected: ((selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyyFavorites = true;
                } else {
                  _showOnlyyFavorites = false;
                }
              });
            }),
            itemBuilder: ((context) => [
                  const PopupMenuItem(
                    value: FilterOptions.Favorites,
                    child: Text('Only Favorites'),
                  ),
                  const PopupMenuItem(
                    value: FilterOptions.All,
                    child: Text('Show All'),
                  )
                ]),
            icon: const Icon(Icons.more_vert),
          ),
          IconButton(
            onPressed: (() {
              authServices.signOut();
            }),
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ProductGrid(
        showONlyFAvorites: _showOnlyyFavorites,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => const AddProductScreen())));
        },
        child: const Text('add'),
      ),
    );
  }
}
