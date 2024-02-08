import 'package:cyra_ecommerce/constants.dart';
import 'package:cyra_ecommerce/models/product.dart';
import 'package:cyra_ecommerce/provider/cart.dart';
import 'package:cyra_ecommerce/webservice/apis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * .6,
                    color: Colors.white,
                    width: double.infinity,
                    child: Image(
                      image: NetworkImage(
                        '${Apis.mainUrl}products/${product.image!}',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(.5),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 2, 20, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          product.productname!,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Rs ${product.price.toString()}',
                        style: TextStyle(
                          color: Colors.red.shade600,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        product.description!,
                        textAlign: TextAlign.start,
                        textScaleFactor: 1.1,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(16),
          child: InkWell(
            onTap: () {
              var existingItemCart = context
                  .read<CartProvider>()
                  .cartItems
                  .firstWhereOrNull((element) => element.id == product.id!);

              if (existingItemCart != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    padding: EdgeInsets.all(15),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    content: Text(
                      'Already in Cart !!!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              } else {
                context.read<CartProvider>().addItem(
                      product.id!,
                      product.productname!,
                      product.price!,
                      1,
                      '${Apis.mainUrl}products/${product.image}',
                    );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    padding: EdgeInsets.all(15),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    content: Text(
                      'Added to Cart !!!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            },
            child: Container(
              height: 50,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: mainColor,
              ),
              child: const Center(
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
