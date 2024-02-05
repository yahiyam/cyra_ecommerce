import 'dart:developer';

import 'package:cyra_ecommerce/constants.dart';
import 'package:cyra_ecommerce/registration.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username, password;
  bool isProcessing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                        color: Color.fromARGB(255, 143, 141, 140),
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
                            setState(() {
                              username = value;
                            });
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
                        color: Color.fromARGB(255, 143, 141, 140),
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
                            setState(() {
                              password = value;
                            });
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
                isProcessing == true
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 7, 2, 78),
                        ),
                      )
                    : Padding(
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
                                log('username = $username');
                                log('password = $password');
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegistrationPage(),
                        ));
                      },
                      child: const Text(
                        'Go to Register',
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
