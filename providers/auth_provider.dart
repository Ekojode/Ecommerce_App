import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  /* final String _token;
  final DateTime _expiryDate;
  final String _userId;*/

  Future<void> signUp(String email, String password) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDDNu-WpomY-BP4UqUyuqkzcWu92ySfaWQ");
    final response = await http.post(
      url,
      body: jsonEncode(
        {"email": email, "password": password, "returnSecureToken": true},
      ),
    );
    print(jsonDecode(response.body));
  }
}
