import 'package:flutter/material.dart';
import 'login.dart'; // Importing the LoginScreen from login.dart

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // Using LoginScreen as the initial route
    ),
  );
}
