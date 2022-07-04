import "package:flutter/material.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        "Welcome Back",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 36, color: Colors.amber),
      )),
    );
  }
}
