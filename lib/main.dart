import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/models/product.dart';
import 'package:shop/providers/pasket_provider.dart';
import 'package:shop/models/products_provider.dart';
import 'package:shop/providers/auths.dart';
import 'package:shop/screens/auth_screen.dart';
import 'package:shop/screens/first_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shop/screens/test_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => ProductProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => Basket()),
        ),
        ChangeNotifierProvider(
          create: ((context) => AuthProvider()),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: const AuthScreen(),
      ),
    );
  }
}
