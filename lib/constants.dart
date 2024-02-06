import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color mainColor = Color.fromARGB(255, 5, 2, 390);
const Color fieldColor = Color.fromARGB(255, 217, 215, 215);

SharedPreferences? pref;

const String networkImage =
    'https://imgs.search.brave.com/TmJ9BTXhF4CYFXH4q5sxrtvZRxnDVdzuR4vvZ6X87qE/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5pc3RvY2twaG90/by5jb20vaWQvMTg1/MDExNzYzL3Bob3Rv/L3Nob2VzLmpwZz9z/PTYxMng2MTImdz0w/Jms9MjAmYz1peVJn/aWR6eDN6cWNGX1hT/UzlrY3JLYW0xaXkw/VVg5bE1GTUlCS3c3/WDJZPQ';
