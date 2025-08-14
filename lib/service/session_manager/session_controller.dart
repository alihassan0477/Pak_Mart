import 'package:pakmart/service/storage/local_storage.dart';

class SellerSessionController {
  late String seller_id;
  late bool isLogin;

  SellerSessionController._() {
    seller_id = "";
    isLogin = false;
  }

  static final SellerSessionController instance = SellerSessionController._();

  factory SellerSessionController() {
    return instance;
  }

  Future<void> saveSellerPrefs(String sellerId, String token) async {
    await LocalStorage().setStringValue("token", token);
    await LocalStorage().setStringValue("seller_id", sellerId);
    await LocalStorage().setStringValue("login", "true");
  }

  Future<void> getSellerPrefs() async {
    final String sellerId = await LocalStorage().getValue("seller_id") ?? "";
    final String isLogin = await LocalStorage().getValue("login") ?? "";

    if (sellerId.isEmpty || sellerId.isEmpty) {
      return;
    }

    SellerSessionController().seller_id = sellerId;

    SellerSessionController().isLogin = isLogin == "true" ? true : false;
  }

  Future<void> clearSellerPrefs() async {
    await LocalStorage().clearValue("seller_id");
    await LocalStorage().clearValue("token");
    await LocalStorage().clearValue("login");

    SellerSessionController().isLogin = false;
    SellerSessionController().seller_id = "";
  }
}
