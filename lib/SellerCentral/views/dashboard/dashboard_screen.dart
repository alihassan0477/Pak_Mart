import 'package:flutter/material.dart';
import 'package:pakmart/Model/SellerModel.dart';
import 'package:pakmart/SellerCentral/views/products/product_screen.dart';
import 'package:pakmart/SellerCentral/views/receive_leads/receive_leads_screen.dart';
import 'package:pakmart/SellerCentral/views/seller_chats/seller_chats_screen.dart';
import 'package:pakmart/SellerCentral/views/user_analytics/user_analytics_screen.dart';
import 'package:pakmart/service/logout_service/logout_service.dart';
import 'package:pakmart/service/session_manager/session_controller.dart';

final List<String> actions = [
  "Product",
  "User Analytics",
  "Received Leads",
  "chats",
];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SellerSessionController().getSellerPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            LogoutService().logoutService(context);
          },
          icon: const Icon(Icons.logout),
        ),
        automaticallyImplyLeading: false,
        title: const Text("Seller Dashboard"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: actions.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              final action = actions[index];
              if (action == "Product") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductSellerScreen(),
                  ),
                );
              } else if (action == "User Analytics") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserAnalyticsScreen(),
                  ),
                );
              } else if (action == "chats") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SellerChatsScreen(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReceiveLeadsScreen(),
                  ),
                );
              }
            },
            child: Card(
              elevation: 5,
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  actions[index],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
