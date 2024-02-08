import 'package:cyra_ecommerce/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        actions: [
          context.watch<CartProvider>().cartItems.isEmpty
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    context.read<CartProvider>().clearCart();
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, _) {
          final cartList = cart.cartItems;
          if (cartList.isEmpty) {
            return const Center(child: Text('Cart is Empty'));
          } else {
            return ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                final product = cartList[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 9),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(product.image.toString()),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      product.name!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rs ${product.price}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red.shade900,
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  product.qty == 1
                                                      ? cart.removeItem(product)
                                                      : cart
                                                          .reduceByOne(product);
                                                },
                                                icon: product.qty == 1
                                                    ? const Icon(
                                                        Icons.delete,
                                                        size: 16,
                                                      )
                                                    : const Icon(
                                                        Icons.minimize_rounded,
                                                        size: 18,
                                                      ),
                                              ),
                                              Text(
                                                product.qty.toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red.shade900,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  cart.increment(product);
                                                },
                                                icon: const Icon(
                                                  Icons.add,
                                                  size: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total : ${context.watch<CartProvider>().totalPrice.toString()}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width / 2.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Order Now',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
