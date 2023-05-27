import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop/widgets/user_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  List searchResult = [];
  List foundUsers = [];
  @override
  Widget build(BuildContext context) {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    Future<void> searchUSer(String searchTerm) async {
      searchResult = [];
      QuerySnapshot querySnapshot =
          await userCollection.where('name', isEqualTo: searchTerm).get();
      for (var doc in querySnapshot.docs) {
        searchResult.add(doc.data());
      }
      setState(() {
        foundUsers = searchResult;
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onEditingComplete: () async {
                await searchUSer(searchController.text.trim());
              },
              controller: searchController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 104, 103, 117),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: foundUsers.length,
              itemBuilder: ((context, index) => UserTile(
                  userName: foundUsers[index]['name'],
                  subtitle: foundUsers[index]['email'])),
            )
          ],
        ),
      ),
    );
  }
}
