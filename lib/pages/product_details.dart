import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:superindo_mobile/helper/api.dart';
import 'package:superindo_mobile/helper/general.dart';
import 'package:superindo_mobile/provider/product_provider.dart';
import 'dart:convert' as convert;

class ProductDetailsScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    getDetailProduct();
  }

  void getDetailProduct() async {
    setState(() {
      _isLoading = true;
    });
    var data = await getDetailProducts(widget.product['detail-endpoint']);

    if (data.isNotEmpty) {
      // ignore: use_build_context_synchronously

      // ignore: use_build_context_synchronously
      context
          .read<DataProductProvider>()
          .setDataProductsDetails(convert.jsonEncode(data));

      setState(() {
        _isLoading = false;
      });
    } else {
      // ignore: use_build_context_synchronously

      // ignore: use_build_context_synchronously
      context.read<DataProductProvider>().setDataProductsDetails({});

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<DataProductProvider>().getDataProductsDetails;

    var productDetails = convert.jsonDecode(data);
    var price = int.parse(widget.product['product_selling_price']);
    var priceDiscount = int.parse(widget.product['product_discount_price']);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFd71309),
        title: const Text("Produk Detail"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: widget.product['default_image_url'],
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${widget.product['name']} ${widget.product['unit']}',
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  FormatCurrency.convertToIdr(
                      int.parse(widget.product['price']), 0),
                  style: const TextStyle(
                      fontSize: 22,
                      color: Color(0xFFd71309),
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              if (priceDiscount > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    FormatCurrency.convertToIdr(price, 0),
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Deskripsi Produk:',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFd71309),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _isLoading
                      ? Row(children: const [
                          Text("Loading"),
                          SizedBox(
                            width: 6,
                          ),
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Color(0xFFd71309),
                              strokeWidth: 1.5,
                            ),
                          ),
                        ])
                      : Text(
                          productDetails['description'],
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade700),
                        )),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'PLU:',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFd71309),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.product['product_plu'],
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xFFd71309)),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Produk berhasil ditambahkan ke keranjang'),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              'Masukkan Keranjang',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
