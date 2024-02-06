import 'package:cyra_ecommerce/constants.dart';
import 'package:cyra_ecommerce/login.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future removePref() async {
    pref?.setBool('isLoggedIn', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(pref?.getString('username') ?? 'null'),
            ElevatedButton(
              onPressed: () {
                removePref()
                    .then((value) => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (route) => false));
              },
              child: const Text('log out'),
            ),
          ],
        ),
      ),
    );
  }
}
