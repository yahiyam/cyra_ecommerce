import 'dart:convert';
import 'dart:developer';

import 'package:cyra_ecommerce/models/cart.dart';
import 'package:cyra_ecommerce/pages/home.dart';
import 'package:cyra_ecommerce/provider/cart.dart';
import 'package:cyra_ecommerce/webservice/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage(
      {super.key,
      required this.cart,
      required this.amount,
      required this.paymentMethod,
      required this.date,
      required this.name,
      required this.address,
      required this.phone,
      required this.username});

  final List<CartModel> cart;
  final String amount;
  final String paymentMethod;
  final String date;
  final String name;
  final String address;
  final String phone;
  final String username;
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void dispose() {
    razorpay!.clear();
    super.dispose();
  }

  Razorpay? razorpay;
  @override
  void initState() {
    razorpay = Razorpay();
    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
    flutterPayment('abcd', 100);
  }

  flutterPayment(String orderId, int t) {
    var options = {
      "key": "rzp_test_ZeCFdtvfg6AjxS",
      "amount": t * 100,
      'name': 'y0ya',
      'currency': 'INR',
      'description': 'maligai',
      'external': {
        'wallets': ["paytm"],
      },
      "retry": {
        'enabled': true,
        "max_count": 1,
      },
      'send_sms_hash': true,
      "prefill": {"contact": "7034534095", 'email': 'y0ya@gmail.com'},
    };
    try {
      razorpay!.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) {
    response.orderId;
    successMethod(response.paymentId.toString());
  }

  successMethod(String paymentId) {
    placeOrder(widget.cart, widget.amount.toString(), widget.paymentMethod,
        widget.date, widget.name, widget.address, widget.phone);
  }

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
        'username': widget.username,
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

  _handlePaymentError(PaymentFailureResponse response) {
    log("error==${response.message}");
  }

  _handleExternalWallet(ExternalWalletResponse response) {
    log("waleeeeeeettttt==");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
