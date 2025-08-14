import 'package:flutter/material.dart';
import 'package:pakmart/screens/Chats/ChatScreen.dart';
import 'package:pakmart/screens/HomeScreen/homeScreen.dart';
import 'package:pakmart/screens/RFQ/RFQScreen.dart';
import 'package:pakmart/screens/Search/SearchScreen.dart';
import 'package:pakmart/screens/UserProfile/profileScreen.dart';
import 'package:pakmart/service/SharedPrefs.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<CustomNavigationBar> {
  int currentPageIndex = 0;
  bool isLogin = false;

  void _tokenCheck() async {
    final token = await SharedPrefs.getPrefsString("token");

    setState(() {
      token.isEmpty ? isLogin = false : isLogin = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tokenCheck();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.green.withOpacity(0.4),
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          const NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          if (isLogin) ...[
            const NavigationDestination(
              icon: Image(
                image: AssetImage("lib/assets/target.png"),
                height: 35,
              ),
              label: 'RFQ',
            ),
          ],
          const NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          if (isLogin) ...[
            const NavigationDestination(icon: Icon(Icons.chat), label: 'Chat'),
          ],
          const NavigationDestination(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
      body:
          <Widget>[
            const HomeScreen(),
            if (isLogin) ...[RFQScreen(isBackButtonEnable: false)],
            const SearchScreen(),
            if (isLogin) ...[const ChatScreen()],
            const UserProfileScreen(),
          ][currentPageIndex],
    );
  }
}
