// ignore_for_file: sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/providers/pasket_provider.dart';
import 'package:shop/models/products_provider.dart';
import 'package:shop/screens/second_screen.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = true;

  void addOrDelete() {
    setState(() {
      isLiked = !isLiked;
    });
    DocumentReference productRed = FirebaseFirestore.instance
        .collection('products')
        .doc(widget.product.id);

    if (isLiked) {
      productRed.update({
        'likes': FieldValue.arrayUnion([currentUser!.email])
      });
    } else {
      productRed.update({
        'likes': FieldValue.arrayRemove([currentUser!.email])
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.product.likes.contains(currentUser!.email);
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(
      context,
    );
    final pasketData = Provider.of<Basket>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => SecondScreen(id: widget.product.id))));
            }),
            child: Image.network(widget.product.imageUrl, fit: BoxFit.cover)),
        footer: GridTileBar(
          trailing: IconButton(
            onPressed: () {
              final snackBar = SnackBar(
                content: pasketData.select(widget.product)
                    ? Text('is deleting')
                    : Text('is adding'),
                action: SnackBarAction(
                    label: 'Back',
                    onPressed: (() {
                      pasketData.addRmFV(widget.product);
                    })),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              pasketData.addRmFV(widget.product);
            },
            icon: Icon(Icons.shopping_cart,
                color: pasketData.select(widget.product)
                    ? Colors.red
                    : Colors.white),
          ),
          title: Text(widget.product.title),
          leading: IconButton(
              onPressed: () {
                addOrDelete();
              },
              icon: isLiked
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    )),
          backgroundColor: Colors.black54,
        ),
      ),
    );
  }
}
