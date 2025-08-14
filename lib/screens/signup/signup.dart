import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pakmart/constant/baseUrl.dart';
import 'package:pakmart/screens/login/login.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final _formKey = GlobalKey<FormState>();

  var _username = "";
  var _email = "";
  var _password = "";
  var confirmPassword = "";

  Future<void> _signUp() async {
    final requestBody = {
      'username': _username,
      'email': _email,
      'password': confirmPassword,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/api/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print("SignUp Successful");
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Account created Successfully',
        buttonsTextStyle: const TextStyle(color: Colors.black),
        transitionAnimationDuration: const Duration(milliseconds: 500),
        autoHide: const Duration(seconds: 2),
        onDismissCallback: (type) => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        ),
      ).show();
    } else {
      print("SignUp failed: ${response.body}");
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Sign Up Failed',
        desc: 'User  already exists or there was an error.',
        buttonsTextStyle: const TextStyle(color: Colors.black),
        autoHide: const Duration(seconds: 2),
        transitionAnimationDuration: const Duration(milliseconds: 500),
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: TextButton(
        style: TextButton.styleFrom(padding: const EdgeInsets.all(30)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        child: const Text('Already have an Account? Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Center(
                  child: Image.asset(
                    "lib/assets/logo/49eb77a2-94d7-4ce5-8038-5309d56705df-removebg-preview.png",
                    scale: 1,
                  ),
                ),
                const Text(
                  'Create an Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
                  validator: (value) {
                    final usernameRegix =
                        RegExp(r'^[a-zA-Z](?=.*[._0-9 ])[a-zA-Z0-9._]+$');
                    if (value == null || value.trim().isEmpty) {
                      return "Username not valid";
                    } else if (value.length < 4) {
                      return "The username should contain at least four characters";
                    } else if (!usernameRegix.hasMatch(value)) {
                      return "Starts with an alphabet and should contain at least one (._ or 0-9 number)";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
                  validator: (value) {
                    final emailRegex = RegExp(
                        r'^[a-zA-Z]+[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter email";
                    } else if (!emailRegex.hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    final passwordRegex = RegExp(
                        r'^[A-Z](?=.*[0-9])(?=.*[!@#$%^&*_.])[A-Za-z0-9!@#$%^&*_.]+$');

                    if (value == null || value.trim().isEmpty) {
                      return "Invalid password";
                    } else if (value.length < 8) {
                      return "Password must be at least 8 characters";
                    } else if (!passwordRegex.hasMatch(value)) {
                      return "Must start with an uppercase letter, contain one special character, and one number";
                    }

                    _password = value;

                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  obscureText: !_confirmPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _confirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter confirm password";
                    } else if (value != _password) {
                      // comparing saved _password
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    confirmPassword = value!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 230),
                  child: OutlinedButton(
                    onPressed: () async {
                      final isValid = _formKey.currentState!.validate();

                      if (!isValid) {
                        return;
                      }

                      _formKey.currentState!.save();
                      _signUp();
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sign up",
                          style: TextStyle(color: Colors.green),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
