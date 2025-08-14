import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pakmart/SellerCentral/views/signup/signup_screen.dart';
import 'package:pakmart/constant/screensize.dart';
import 'package:pakmart/extension/route_extension.dart';
import 'package:pakmart/screens/BottomNavigation.dart';
import 'package:pakmart/screens/login/login.dart';
import 'package:pakmart/screens/signup/signup.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scafold means screen
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Logo(),
              Button(
                KEY: "Login",
                onPressed: () {
                  context.navigateTo(const LoginScreen());

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const LoginScreen(),
                  //     ));
                },
                text: "Sign in",
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 70),
                child: Button(
                  KEY: "Create Account",
                  onPressed: () {
                    context.navigateTo(const SignUpScreen());
                  },
                  text: "Create Account",
                ),
              ),
              Button(
                KEY: "Seller",
                onPressed: () {
                  context.navigateTo(const SellerSignup());

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const LoginScreen(),
                  //     ));
                },
                text: "Register as a Seller",
              ),
              Button(
                KEY: "Guest",
                onPressed: () {
                  context.navigateTo(const CustomNavigationBar());

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const LoginScreen(),
                  //     ));
                },
                text: "Enter as a Guest",
              ),
              const SocialMedia(),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialMedia extends StatelessWidget {
  const SocialMedia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SocialButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.linkedinIn,
            color: Colors.blue,
            size: 35,
          ),
          heroTag: 'linkedin',
        ),
        SocialButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.instagram,
            color: Colors.pink,
            size: 35,
          ),
          heroTag: 'instagram',
        ),
        SocialButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.facebook,
            size: 35,
          ),
          heroTag: 'facebook',
        ),
        SocialButton(
          onPressed: () {},
          icon: const FaIcon(
            FontAwesomeIcons.twitter,
            color: Colors.blue,
            size: 35,
          ),
          heroTag: 'twitter',
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton(
      {super.key, required this.onPressed, required this.icon, this.heroTag});

  final void Function()? onPressed;
  final FaIcon icon;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: onPressed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: icon,
    );
  }
}

class Button extends StatelessWidget {
  Button(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.KEY});

  void Function() onPressed;
  String text;
  String KEY;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      key: Key(KEY),
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.green,
        side: const BorderSide(color: Colors.green),
        fixedSize: Size(Screensize(context: context).screenWidth - 150, 60),
      ),
      child: Text(text),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Screensize(context: context).screenheight / 2.7,
      width: Screensize(context: context).screenWidth,
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
      child: const Image(
          fit: BoxFit.cover,
          image: AssetImage(
            "lib/assets/logo/49eb77a2-94d7-4ce5-8038-5309d56705df-removebg-preview.png",
          )),
    );
  }
}
