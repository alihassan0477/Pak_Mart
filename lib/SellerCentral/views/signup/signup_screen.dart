import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pakmart/Model/SellerModel.dart';
import 'package:pakmart/SellerCentral/views/login/login_seller_screen.dart';
import 'package:pakmart/api/Seller_Api.dart';
import 'package:pakmart/constant/buttonStyle.dart';
import 'package:pakmart/extension/route_extension.dart';

class SellerSignup extends StatefulWidget {
  const SellerSignup({super.key});

  @override
  State<SellerSignup> createState() => _SellerSignupState();
}

class _SellerSignupState extends State<SellerSignup> {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> controllers = List.generate(
    7,
    (index) => TextEditingController(),
  );

  final List<String> namesOfTextFields = [
    "Email",
    "Password",
    "Display Name",
    "CNIC",
    "Phone Number",
    "Shop Name",
    "Residential Address",
  ];

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Seller Sign up'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: 150,
                      child: Image.asset(
                        fit: BoxFit.contain,
                        "lib/assets/logo/49eb77a2-94d7-4ce5-8038-5309d56705df-removebg-preview.png",
                      ),
                    ),
                  ),
                  const Text(
                    "Seller Central !",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                  ),
                  _signTextFields(),
                  TextButton(
                    onPressed: () {
                      context.navigateTo(const LoginSellerScreen(
                        isAppBarVisible: true,
                      ));
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.green),
                    child: const Text("Already a Seller"),
                  ),
                  Center(
                    child: ElevatedButton(
                      style: outlinedButton.copyWith(
                        fixedSize: WidgetStatePropertyAll<Size>(
                          Size(MediaQuery.of(context).size.width / 1.5, 50),
                        ),
                      ),
                      onPressed: signup,
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signTextFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        namesOfTextFields.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextFormField(
              controller: controllers[index],
              inputFormatters: _getInputFormatters(index),
              decoration: InputDecoration(
                labelText: namesOfTextFields[index],
                border: const OutlineInputBorder(),
              ),
              obscureText: index == 1, // Obscure text for the password field
              keyboardType: _getKeyboardType(index),
              validator: (value) => _validateInput(index, value),
            ),
          );
        },
      ),
    );
  }

  List<TextInputFormatter>? _getInputFormatters(int index) {
    if (index == 3 || index == 4) {
      // CNIC or Phone Number - Digits only
      return [FilteringTextInputFormatter.digitsOnly];
    }
    return null; // No formatters for other fields
  }

  void clearControllers() {
    for (int index = 0; index < controllers.length; index++) {
      controllers[index].clear();
    }

    setState(() {});
  }

  TextInputType _getKeyboardType(int index) {
    switch (index) {
      case 0:
        return TextInputType.emailAddress; // Email
      case 3:
        return TextInputType.number; // CNIC
      case 4:
        return TextInputType.phone; // Phone Number
      default:
        return TextInputType.text; // Default
    }
  }

  String? _validateInput(int index, String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter ${namesOfTextFields[index]}';
    }

    switch (index) {
      case 0: // Email validation
        if (!RegExp(r'^[a-zA-Z]+[a-zA-Z0-9._]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        break;

      case 1: // Password validation
        if (!RegExp(
                r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_.])[A-Za-z0-9!@#$%^&*_.]{8,}$')
            .hasMatch(value)) {
          return 'Password must be at least 8 characters, include 1 uppercase letter, 1 number, and 1 special character.';
        }
        break;

      case 3: // CNIC validation
        if (value.length != 13) {
          return 'CNIC must be exactly 13 digits';
        }
        break;

      case 4: // Phone number validation
        if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
          return 'Phone number must be 10–15 digits';
        }
        break;
    }

    return null; // Valid input
  }

  void signup() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (isValid) {
      final formData =
          controllers.map((controller) => controller.text).toList();
      print('Form Data: $formData');

      final seller = Seller(
        email: formData[0],
        name: formData[2],
        cnic: formData[3],
        phoneNo: formData[4],
        storeName: formData[5],
        residentialAddress: formData[6],
      );

      // Call API

      SellerApi().signUp(seller, formData[1]).then((response) {
        if (response == 200) {
          // Success
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Signup successful!')),
          );

          clearControllers();
        } else if (response == 400) {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Email, phone number, or CNIC already exists.')),
          );
        }
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unexpected error occurred!')),
        );
      });
    }
  }
}
