import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthStatusScreenState();
}

class _AuthStatusScreenState extends State<AuthScreen> {
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _formKey = GlobalKey<FormState>();
  AuthStatus _authStatus = AuthStatus.signUp;
  bool _isObscure = true;
  bool _isConfirmPasswordObscure = true;
  bool _isLoading = false;
  final _passwordFocusNode = FocusNode();
  final _passwordController = TextEditingController();

  /*void _updatePasswordFocus() {
    if (!_passwordFocusNode.hasFocus) {
      setState(() {});
    }
  }*/

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_authStatus == AuthStatus.logIn) {
      // Log user in
    } else {
      Provider.of<Auth>(context, listen: false)
          .signUp(_authData["email"]!, _authData["password"]!);
    }
    setState(() {
      _isLoading = false;
    });
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
              //  Sign(),
              SizedBox(
                height: deviceSize.height * 0.025,
              ),
              SizedBox(
                height: deviceSize.height * 0.4,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(_authStatus == AuthStatus.signUp
                          ? "https://t4.ftcdn.net/jpg/04/28/75/97/360_F_428759715_jsOPITlaytE3QXc2yI1D4U6uwZdVGkRp.jpg"
                          : "https://thumbs.dreamstime.com/b/account-login-password-key-computer-man-near-vector-male-character-design-concept-landing-page-web-poster-banner-184009994.jpg"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: _authStatus == AuthStatus.signUp
                    ? deviceSize.height * 0.42
                    : deviceSize.height * 0.32,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _authStatus == AuthStatus.signUp ? "Sign Up" : "Log In",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is reqired!";
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "Please enter a valid email!";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData["email"] = value!;
                        },
                        decoration: const InputDecoration(
                            icon: Icon(Icons.email_outlined),
                            hintText: "Email ID"),
                      ),
                      TextFormField(
                        onSaved: (newValue) {
                          _authData["password"] = newValue!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a password";
                          }
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return "Please enter a strong password!";
                          }
                          return null;
                        },
                        controller: _passwordController,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                                icon: Icon(_isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            hintText: "Password"),
                        obscureText: _isObscure,
                      ),
                      _authStatus == AuthStatus.signUp
                          ? SizedBox(
                              child: _passwordController.text.isEmpty
                                  ? null
                                  : const Text("data"),
                            )
                          : const SizedBox(),
                      _authStatus == AuthStatus.logIn
                          ? Row(
                              children: [
                                const Spacer(),
                                SizedBox(
                                  child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Forgot Password?",
                                        textAlign: TextAlign.end,
                                      )),
                                ),
                              ],
                            )
                          : TextFormField(
                              enabled: _authStatus == AuthStatus.signUp,
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return "Ensure Passwords are same";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isConfirmPasswordObscure =
                                              !_isConfirmPasswordObscure;
                                        });
                                      },
                                      icon: Icon(_isConfirmPasswordObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off)),
                                  hintText: "Confirm Password"),
                              obscureText: _isConfirmPasswordObscure,
                            ),
                      _authStatus == AuthStatus.signUp
                          ? SizedBox(
                              child: Center(
                                child: RichText(
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        children: [
                                      const TextSpan(
                                          text:
                                              "By signing up, you agree to our "),
                                      TextSpan(
                                          text: "Terms & Conditions",
                                          style: TextStyle(
                                              color: Colors.blue.shade700,
                                              fontWeight: FontWeight.bold)),
                                      const TextSpan(text: " and"),
                                      TextSpan(
                                          text: " Privacy Policy",
                                          style: TextStyle(
                                              color: Colors.blue.shade700,
                                              fontWeight: FontWeight.bold)),
                                    ])),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: deviceSize.height * 0.01,
                      )
                    ],
                  ),
                ),
              ),
              _isLoading
                  ? const SizedBox(
                      child: Center(
                      child: CircularProgressIndicator(),
                    ))
                  : InkWell(
                      onTap: _submit,
                      child: Center(
                        child: Container(
                          height: deviceSize.height * 0.075,
                          width: deviceSize.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.blue[700],
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            _authStatus == AuthStatus.signUp
                                ? "Continue"
                                : "Log In",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
                        ),
                      ),
                    ),
              SizedBox(
                height: deviceSize.height * 0.01,
              ),
              _authStatus == AuthStatus.logIn
                  ? Column(
                      children: [
                        Row(
                          children: const [
                            Expanded(
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            Text("  OR  "),
                            Expanded(
                                child: Divider(
                              thickness: 2,
                            ))
                          ],
                        ),
                        SizedBox(
                          height: deviceSize.height * 0.01,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Center(
                            child: Container(
                              height: deviceSize.height * 0.075,
                              width: deviceSize.width * 0.9,
                              decoration: BoxDecoration(
                                  color: const Color(0xfff1f5f6),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(FontAwesomeIcons.google),
                                  SizedBox(
                                    width: deviceSize.width * 0.05,
                                  ),
                                  const Text(
                                    "Log In with Google",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: deviceSize.height * 0.01,
                        ),
                      ],
                    )
                  : SizedBox(
                      height: deviceSize.height * 0.01,
                    ),
              GestureDetector(
                onTap: () {
                  if (_authStatus == AuthStatus.signUp) {
                    setState(() {
                      _authStatus = AuthStatus.logIn;
                    });
                  } else {
                    setState(() {
                      _authStatus = AuthStatus.signUp;
                    });
                  }
                },
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                            text: _authStatus == AuthStatus.signUp
                                ? "Joined us before? "
                                : "New to Kide Commerce? "),
                        TextSpan(
                            text: _authStatus == AuthStatus.signUp
                                ? "Login"
                                : "Register",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700))
                      ],
                    ),
                  ),
                ),
              ),
              /*          ElevatedButton(
                  onPressed: () {
                    if (_AuthStatusStatus == AuthStatus.signUp) {
                      setState(() {
                        _AuthStatusStatus = AuthStatus.logIn;
                      });
                    } else {
                      setState(() {
                        _AuthStatusStatus = AuthStatus.signUp;
                      });
                    }
                  },
                  child: const Text("Switch Screen")),*/
              SizedBox(
                height: deviceSize.height * 0.025,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum AuthStatus {
  signUp,
  logIn,
}
