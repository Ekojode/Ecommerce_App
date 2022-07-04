import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exceptions.dart';

class Auth with ChangeNotifier {
  late String _token;
  DateTime _expiryDate = DateTime(2022, 1, 1);
  late String _userId;
  Timer _authTimer = Timer(const Duration(days: 1), () {});

  String get token {
    if (_expiryDate != DateTime(2022, 1, 1) &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != "") {
      return _token;
    }
    return "";
  }

  String get userId {
    return _userId;
  }

  bool get isAuth {
    return token != "";
  }

  Future<void> authenticate(
      String email, String password, String status) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$status?key=AIzaSyDDNu-WpomY-BP4UqUyuqkzcWu92ySfaWQ");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {"email": email, "password": password, "returnSecureToken": true},
        ),
      );

      final responseData = jsonDecode(response.body);

      //  print(responseData);

      if (responseData["error"] != null) {
        throw HttpExceptions(responseData["error"]["message"]);
      }
      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(responseData["expiresIn"]),
        ),
      );
      _autoLogOut();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode(
        {
          "token": _token,
          "userId": _userId,
          "expiryDate": _expiryDate.toIso8601String(),
        },
      );
      prefs.setString("userData", userData);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    return authenticate(email, password, "signUp");
  }

  Future<void> logIn(String email, String password) async {
    return authenticate(email, password, "signInWithPassword");
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return false;
    }
    final extractedUserData =
        jsonDecode(prefs.getString("userData")!) as Map<String, dynamic>;
    final expiryDate =
        DateTime.parse(extractedUserData["expiryDate"] as String);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData["token"] as String;
    _userId = extractedUserData["userId"] as String;
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogOut();
    return true;
  }

  Future<void> logOut() async {
    _token = "";
    _userId = "";
    _expiryDate = DateTime(2022, 1, 1);
    if (_authTimer != Timer(const Duration(days: 1), () {})) {
      _authTimer.cancel();
      _authTimer = Timer(const Duration(days: 1), () {});
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogOut() {
    if (_authTimer != Timer(const Duration(days: 1), () {})) {
      _authTimer.cancel();
    }
    final timeToLogOut = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToLogOut), logOut);
  }
}
