import 'package:flutter/material.dart';
import 'package:superindo_mobile/components/product_card.dart';
import 'package:superindo_mobile/pages/product_details.dart';

class ProductGrid extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final products;
  const ProductGrid({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductCard(
        product: products[index],
        onClick: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailsScreen(product: products[index]),
            ),
          );
        },
      ),
    );
  }
}
