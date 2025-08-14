import 'package:flutter/material.dart';
import 'package:pakmart/SellerCentral/views/signup/signup_screen.dart';
import 'package:pakmart/api/UserApi.dart';
import 'package:pakmart/constant/screensize.dart';
import 'package:pakmart/constant/textStyles.dart';
import 'package:pakmart/extension/route_extension.dart';
import 'package:pakmart/screens/Categories/CategoryScreen.dart';
import 'package:pakmart/screens/login/login.dart';
import 'package:pakmart/screens/signup/signup.dart';
import 'package:pakmart/service/SharedPrefs.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isLogin = false;
  String? email;
  String? username;
  Future<void> checkStatus() async {
    String status = await SharedPrefs.getUserID();

    final isFetched = await User.get_username_email();

    if (status.isNotEmpty && isFetched == true) {
      username = await SharedPrefs.getPrefsString("username");
      email = await SharedPrefs.getPrefsString("email");

      setState(() {
        isLogin = true;
      });
    } else {
      setState(() {
        isLogin = false;
      });
    }

    // print(status);

    // setState(() {
    //   status.isEmpty ? isLogin = false : isLogin = true;
    // });
  }

  void _logout() async {
    await SharedPrefs.removePrefs("email");
    await SharedPrefs.removePrefs("username");
    await SharedPrefs.removePrefs("user_id");
    await SharedPrefs.removePrefs("token");

    context.navigateTo(const LoginScreen());
  }

  @override
  void initState() {
    super.initState();

    checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLogin ? _userProfileHeader() : _header(context),
              const Divider(),
              ListTile(
                contentPadding: const EdgeInsets.all(6),
                leading: const Icon(Icons.category),
                title: const Text("All Categories"),
                onTap: () {
                  context.navigateTo(const CategoryScreen());
                },
              ),
              const Divider(),
              const Divider(),
              ListTile(
                contentPadding: const EdgeInsets.all(6),
                leading: const Icon(Icons.money),
                title: const Text("Become a seller"),
                onTap: () {
                  context.navigateTo(const SellerSignup());
                },
              ),
              const Divider(),
              ListTile(
                contentPadding: const EdgeInsets.all(6),
                leading: const Icon(Icons.privacy_tip),
                title: const Text("Privacy policy"),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                contentPadding: const EdgeInsets.all(6),
                leading: const Icon(Icons.info),
                title: const Text("About Us"),
                onTap: () {},
              ),
              const Divider(),
              if (isLogin)
                ListTile(
                  contentPadding: const EdgeInsets.all(6),
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap: _logout,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userProfileHeader() {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.person,
            size: 100,
          ),
          Text(
            username!,
            style: boldWith20px.copyWith(fontSize: 25),
          ),
          Text(
            email!,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Your Profile",
          style: boldWith18px,
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "Please Log in to go to your profile",
          style: extraLightWith16px,
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            context.navigateTo(const LoginScreen());
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(Screensize(context: context).screenWidth - 50, 50),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: const Text("Login"),
        ),
        Row(
          children: [
            const Text("Dont have an account ?"),
            TextButton(
                onPressed: () {
                  context.navigateTo(const SignUpScreen());
                },
                child: const Text("Signup"))
          ],
        ),
      ],
    );
  }
}
