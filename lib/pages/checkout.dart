import 'dart:convert';

import 'package:cyra_ecommerce/constants.dart';
import 'package:cyra_ecommerce/models/cart.dart';
import 'package:cyra_ecommerce/models/user.dart';
import 'package:cyra_ecommerce/pages/home.dart';
import 'package:cyra_ecommerce/pages/payment.dart';
import 'package:cyra_ecommerce/provider/cart.dart';
import 'package:cyra_ecommerce/webservice/apis.dart';
import 'package:cyra_ecommerce/webservice/web_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartModel> cartList;
  const CheckoutPage({super.key, required this.cartList});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedValue = 1;
  String? username;

  @override
  void initState() {
    _loadUsername();
    super.initState();
  }

  void _loadUsername() async {
    setState(() {
      username = pref!.getString('username');
    });
  }

  String? name, address, phone;
  String? paymentMethod = 'Cash on delivery';

  placeOrder(
    List<CartModel> cart,
    String amount,
    String paymentMethod,
    String date,
    String name,
    String address,
    String phone,
  ) async {
    String jsonData = jsonEncode(cart);
    final vm = Provider.of<CartProvider>(context, listen: false);
    final response = await http.post(
      Uri.parse(Apis.order),
      body: {
        'username': username,
        'amount': amount,
        "paymentmethod": paymentMethod,
        'date': date,
        "quantity": vm.count.toString(),
        "cart": jsonData,
        'name': name,
        'address': address,
        'phone': phone,
      },
    );
    if (response.statusCode == 200) {
      if (response.body.contains('Success') && context.mounted) {
        vm.clearCart();
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
              'Your order successfully placed',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CartProvider>(context, listen: false);
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
          'Checkout',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: FutureBuilder<UserModel>(
                future: WebService().fetchUser(username.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    name = snapshot.data!.name;
                    phone = snapshot.data!.phone;
                    address = snapshot.data!.address;
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Name : ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                name.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                'Phone : ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                phone.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Text(
                                'Address : ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width / 1.5,
                                child: Text(
                                  address!,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(color: mainColor));
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            RadioListTile(
              activeColor: mainColor,
              value: 1,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                  paymentMethod = 'Cash on delivery';
                });
              },
              title: const Text('Cash on delivery'),
              subtitle: const Text('Pay cash from home'),
            ),
            RadioListTile(
              activeColor: mainColor,
              value: 2,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                  paymentMethod = 'Online';
                });
              },
              title: const Text('Pay Now'),
              subtitle: const Text('Online payment'),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16),
        child: InkWell(
          onTap: () {
            String dateTime = DateTime.now().toString();

            if (paymentMethod == "Online") {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PaymentPage(
                  cart: widget.cartList,
                  amount: vm.totalPrice.toString(),
                  paymentMethod: paymentMethod!,
                  date: dateTime,
                  name: name!,
                  address: address!,
                  phone: phone!,
                  username: username!,
                ),
              ));
            } else if (paymentMethod == 'Cash on delivery') {
              placeOrder(widget.cartList, vm.totalPrice.toString(),
                  paymentMethod!, dateTime, name!, address!, phone!);
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
                'Checkout',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
