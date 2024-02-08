import 'package:cyra_ecommerce/constants.dart';
import 'package:cyra_ecommerce/login.dart';
import 'package:cyra_ecommerce/pages/cart.dart';
import 'package:cyra_ecommerce/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'E-commerce',
                style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: badge.Badge(
                showBadge: context.read<CartProvider>().cartItems.isEmpty
                    ? false
                    : true,
                badgeAnimation: const badge.BadgeAnimation.fade(),
                badgeStyle: const badge.BadgeStyle(badgeColor: Colors.red),
                badgeContent: Text(
                  context.read<CartProvider>().cartItems.length.toString(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: const Icon(Icons.shopping_bag_rounded),
              ),
              title: const Text(
                'Cart Page',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(
                'Order Details',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.power_settings_new_rounded,
                color: Colors.redAccent,
              ),
              title: const Text(
                'Log out',
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
              onTap: () {
                pref?.setBool('isLoggedIn', false);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
