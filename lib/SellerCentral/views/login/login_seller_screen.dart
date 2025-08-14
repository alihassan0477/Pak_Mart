import 'package:flutter/material.dart';
import 'package:pakmart/SellerCentral/views/dashboard/dashboard_screen.dart';
import 'package:pakmart/api/Seller_Api.dart';
import 'package:pakmart/constant/buttonStyle.dart';
import 'package:pakmart/extension/route_extension.dart';
import 'package:pakmart/service/session_manager/session_controller.dart';

class LoginSellerScreen extends StatefulWidget {
  const LoginSellerScreen({super.key, this.isAppBarVisible = false});

  final bool isAppBarVisible;

  @override
  State<LoginSellerScreen> createState() => _LoginSellerScreenState();
}

class _LoginSellerScreenState extends State<LoginSellerScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final response = await SellerApi().sellerLogin(email.text, password.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );

      if (response == "Login Sucessful") {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            context.navigateTo(const DashboardScreen());
          },
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppBarVisible
          ? AppBar(
              title: const Text("Seller Login"),
            )
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "lib/assets/logo/49eb77a2-94d7-4ce5-8038-5309d56705df-removebg-preview.png",
                  scale: 3,
                ),
                const Text(
                  'Welcome Seller!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _isLoading
                    ? const CircularProgressIndicator()
                    : OutlinedButton(
                        onPressed: _login,
                        style: outlinedButton,
                        child: const Text("Login"),
                      ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.green),
                  onPressed: () {},
                  child: const Text('Register as a new seller'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
