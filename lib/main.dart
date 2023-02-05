import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superindo_mobile/pages/product.dart';
import 'package:superindo_mobile/provider/product_provider.dart';

void main() {
  runApp((MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DataProductProvider()),
  ], child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Super Indo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Product(),
    );
  }
}
