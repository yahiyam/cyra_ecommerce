import 'dart:convert';
import 'dart:developer';

import 'package:cyra_ecommerce/api.dart';
import 'package:cyra_ecommerce/constants.dart';
import 'package:cyra_ecommerce/login.dart';
import 'package:cyra_ecommerce/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    String? name, phone, address, username, password;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        if (response.body.contains('succuss') && context.mounted) {
          log('registration successfully completed');

          Navigator.of(context).push(MaterialPageRoute(
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
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Complete your details  \n'),
            const SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                children: [
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
                              hintText: 'Name',
                            ),
                            onChanged: (value) {
                              setState(() {
                                name = value;
                              });
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
                          color: Color.fromARGB(255, 143, 141, 140),
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
                              setState(() {
                                phone = value;
                              });
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
                          color: Color.fromARGB(255, 143, 141, 140),
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
                              setState(() {
                                address = value;
                              });
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
                          color: Color.fromARGB(255, 143, 141, 140),
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
                          if (formKey.currentState!.validate()) {
                            log('name = $name');
                            log('phone = $phone');
                            log('address = $address');
                            log('username = $username');
                            log('password = $password');
                            register(
                              name!,
                              phone,
                              address,
                              username,
                              password,
                            );
                            final pref = await SharedPreferences.getInstance();
                            pref.setBool('isLoggedIn', true);
                            pref.setString('username', username!);
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
                          Navigator.of(context).push(MaterialPageRoute(
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
