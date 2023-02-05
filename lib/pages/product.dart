import 'package:flutter/material.dart';
import 'package:superindo_mobile/components/product_grid.dart';
import 'package:superindo_mobile/components/product_grid_loading.dart';
import 'package:superindo_mobile/helper/api.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  var _foundProduct = [];
  var _permanentProduct = [];
  @override
  void initState() {
    super.initState();
    getDataProduct();
  }

  getDataProduct() async {
    var data = await getAllProducts();

    if (data.isNotEmpty) {
      setState(() {
        _foundProduct = data;
        _permanentProduct = data;
      });
    } else {
      setState(() {
        _foundProduct = [];
      });
    }
  }

  void _searchProducts(String enteredKeyword) {
    var results = [];

    if (enteredKeyword.isEmpty) {
      results = _permanentProduct;
    } else {
      results = _foundProduct
          .where((product) => product['name']
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundProduct = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFd71309),
          title: const Text(
            "Produk",
            style: TextStyle(color: Color(0xFFFFFFFF)),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => _searchProducts(value),
                  decoration: const InputDecoration(
                    hintText: "Cari Produk...",
                    suffixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Expanded(
                    child: _foundProduct.isNotEmpty
                        ? ProductGrid(products: _foundProduct)
                        : const ProductGridLoading())
              ],
            ),
          ),
        ));
  }
}
