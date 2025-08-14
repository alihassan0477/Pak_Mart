import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pakmart/constant/baseUrl.dart';
import 'package:http/http.dart' as http;
import 'package:pakmart/extension/route_extension.dart';
import 'package:pakmart/screens/BottomNavigation.dart';
import 'package:pakmart/screens/signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  bool progressIndicator = false;
  var height = AppBar().preferredSize.height;
  final _formKey = GlobalKey<FormState>();
  var _email = "";
  var _password = "";

  Future<void> _login() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    try {
      final requestBody = {
        'email': _email,
        'password': _password,
      };

      final response = await http.post(Uri.parse('$baseUrl/api/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final token = responseData['token'];
        final userId = responseData['_id'];

        print(userId);

        print(responseData);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('user_id', userId);

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CustomNavigationBar(),
            ));
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Invalid Username or Password',
          buttonsTextStyle: const TextStyle(color: Colors.black),
          showCloseIcon: true,
        ).show();
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TextButton(
        style: TextButton.styleFrom(padding: const EdgeInsets.all(30)),
        onPressed: () {
          context.navigateTo(const SignUpScreen());
        },
        child: const Text('Create a Account ? Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height + 10,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: Image.asset(
                        "lib/assets/logo/49eb77a2-94d7-4ce5-8038-5309d56705df-removebg-preview.png",
                        scale: 2),
                  ),
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please Enter Email";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple)),
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
                    if (value == null || value.trim().isEmpty) {
                      return "Invalid password";
                    } else if (value.length < 8) {
                      return "please enter password greater then 8 ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 230),
                  child: OutlinedButton(
                    onPressed: () {
                      _login();

                      // context.navigateTo(const CustomNavigationBar());
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Login",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
