import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  Auth authStatus = Auth.signIn;
  final _isObscure = true;
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            //    mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: deviceSize.height * 0.05,
              ),
              SizedBox(
                height: deviceSize.height * 0.35,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(authStatus == Auth.signIn
                          ? "https://t4.ftcdn.net/jpg/04/28/75/97/360_F_428759715_jsOPITlaytE3QXc2yI1D4U6uwZdVGkRp.jpg"
                          : "https://thumbs.dreamstime.com/b/account-login-password-key-computer-man-near-vector-male-character-design-concept-landing-page-web-poster-banner-184009994.jpg"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: authStatus == Auth.signIn
                    ? deviceSize.height * 0.45
                    : deviceSize.height * 0.35,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authStatus == Auth.signIn ? "Sign Up" : "Log In",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined),
                          SizedBox(width: deviceSize.width * 0.02),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(hintText: "Email ID"),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.lock_outlined),
                          SizedBox(width: deviceSize.width * 0.02),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(hintText: "Password"),
                              obscureText: _isObscure,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (authStatus == Auth.signIn) {
                      setState(() {
                        authStatus = Auth.logIn;
                      });
                    } else {
                      setState(() {
                        authStatus = Auth.signIn;
                      });
                    }
                  },
                  child: const Text("Switch Screen"))
            ],
          ),
        ),
      ),
    );
  }
}

enum Auth {
  signIn,
  logIn,
}
