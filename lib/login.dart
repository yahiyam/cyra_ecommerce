import 'dart:convert';
import 'dart:developer';

import 'package:cyra_ecommerce/constants.dart';
import 'package:cyra_ecommerce/pages/home.dart';
import 'package:cyra_ecommerce/registration.dart';
import 'package:cyra_ecommerce/webservice/apis.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _loadCounter();
    super.initState();
  }

  _loadCounter() async {
    final pref = await SharedPreferences.getInstance();
    bool isLoggedIn = pref.getBool('isLoggedIn') ?? false;
    if (isLoggedIn && context.mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    }
  }

  login(String username, password) async {
    dynamic result;
    final Map loginData = <String, dynamic>{
      'username': username,
      'password': password,
    };
    final response = await http.post(
      Uri.parse(Apis.login),
      body: loginData,
    );
    if (response.statusCode == 200) {
      if (response.body.contains('success') && context.mounted) {
        pref?.setBool('isLoggedIn', true);
        pref?.setString('username', username);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
      } else {
        log('Login failed');
      }
    } else {
      result = {log(json.decode(response.body)["error"].toString())};
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 200),
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 28,
                    color: mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Login with your username and password  \n',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: const BoxDecoration(
                        color: fieldColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Username',
                          ),
                          onChanged: (value) {
                            username = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: const BoxDecoration(
                        color: fieldColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          obscureText: true,
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Password',
                          ),
                          onChanged: (value) {
                            password = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your Password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: mainColor,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login(username!, password);
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const RegistrationPage(),
                        ));
                      },
                      child: const Text(
                        '  Register',
                        style: TextStyle(
                          fontSize: 16,
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
