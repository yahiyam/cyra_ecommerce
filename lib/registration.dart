import 'dart:convert';
import 'dart:developer';

import 'package:cyra_ecommerce/constants.dart';
import 'package:cyra_ecommerce/login.dart';
import 'package:cyra_ecommerce/pages/home.dart';
import 'package:cyra_ecommerce/webservice/apis.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String? name, phone, address, username, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    setPref() async {
      pref?.setBool('isLoggedIn', true);
      pref?.setString('username', username!);
    }

    register(String name, phone, address, username, password) async {
      dynamic result;
      final Map loginData = <String, dynamic>{
        'name': name,
        'phone': phone,
        'address': address,
        'username': username,
        'password': password,
      };
      final response = await http.post(
        Uri.parse(Apis.register),
        body: loginData,
      );
      if (response.statusCode == 200) {
        if (response.body.contains('success') && context.mounted) {
          log('registration successfully completed');

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
        } else {
          log('registration failed');
        }
      } else {
        result = {log(json.decode(response.body)["error"].toString())};
      }
      return result;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              'Register Account',
              style: TextStyle(
                fontSize: 28,
                color: mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Complete your details  \n'),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
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
                              hintText: 'Name',
                            ),
                            onChanged: (value) {
                              name = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Name';
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
                            style: const TextStyle(fontSize: 15),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Phone',
                            ),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              phone = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Phone';
                              } else if (value.length != 10) {
                                return 'Please enter a valid number';
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
                      height: 100,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: const BoxDecoration(
                          color: fieldColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            maxLines: 4,
                            style: const TextStyle(fontSize: 15),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Address',
                            ),
                            onChanged: (value) {
                              address = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Address';
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
                            style: const TextStyle(fontSize: 15),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Username',
                            ),
                            onChanged: (value) {
                              username = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Username';
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            register(
                              name!,
                              phone,
                              address,
                              username,
                              password,
                            ).then((value) => setPref());
                          }
                        },
                        child: const Text(
                          'Register',
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
                        "Do you have an account? ",
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                        },
                        child: const Text(
                          '  Login',
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
          ],
        ),
      ),
    );
  }
}
