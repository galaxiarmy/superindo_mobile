import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:superindo_mobile/helper/general.dart';

class ProductCard extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final product;
  // ignore: prefer_typing_uninitialized_variables
  final onClick;
  const ProductCard({Key? key, required this.product, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var price = int.parse(product['product_selling_price']);

    var priceDiscount = int.parse(product['product_discount_price']);

    return InkWell(
      onTap: onClick,
      child: Material(
        elevation: 8,
        shadowColor: Colors.grey.shade300,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 5,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: product['default_image_url'],
                    placeholder: (context, url) => Shimmer.fromColors(
                      highlightColor: Colors.white,
                      baseColor: Colors.grey.shade300,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.grey.shade300,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF000000)),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      FormatCurrency.convertToIdr(price, 0),
                      style: TextStyle(
                          decoration: priceDiscount > 0
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          fontSize: priceDiscount > 0 ? 12 : 16,
                          color: priceDiscount > 0
                              ? Colors.grey
                              : const Color(0xFFd71309),
                          fontWeight: priceDiscount > 0
                              ? FontWeight.normal
                              : FontWeight.bold),
                    ),
                    if (priceDiscount > 0)
                      Text(
                        FormatCurrency.convertToIdr(priceDiscount, 0),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFd71309)),
                      ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFd71309),
                        minimumSize: const Size.fromHeight(34), // NEW
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Produk berhasil ditambahkan ke keranjang'),
                          ),
                        );
                      },
                      child: const Text(
                        '+ Keranjang',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
