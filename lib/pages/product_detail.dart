import 'package:cyra_ecommerce/constants.dart';
import 'package:cyra_ecommerce/models/product.dart';
import 'package:cyra_ecommerce/webservice/apis.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key, required this.product});
  final ProductModel product;
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
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
                    height: MediaQuery.sizeOf(context).height * .8,
                    color: Colors.white,
                    width: double.infinity,
                    child: Image(
                      image: NetworkImage(
                        '${Apis.mainUrl}/products${widget.product.image!}',
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
                          widget.product.productname!,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Rs ${widget.product.price.toString()}',
                        style: TextStyle(
                          color: Colors.red.shade600,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.product.description!,
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
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 50,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: mainColor,
            ),
            child: const Text(
              'Add to Cart',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
