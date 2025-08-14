import 'package:pakmart/service/session_manager/session_controller.dart';

class AppUrl {
  static const String baseApi = "http://$ANDROID_EMULATOR_IP:$PORT";
  static const PORT = "2000";
  static const String NGROK =
      "https://8707-2400-adc1-136-6300-4ce4-acd0-d726-8939.ngrok-free.app";
  static const String LOCAL_HOST = "localhost";
  static const String MAC_IP = "192.168.18.91";
  static const String ANDROID_EMULATOR_IP = "10.0.2.2";
  static const String TEMP_IP = "172.16.182.32";

  static const FETCH_CATEGORIES = "$baseApi/api/get-categories";

  static const CREATE_PRODUCT = "$baseApi/api/create-product";

  static String getSellerIdUrl(String sellerId) {
    return "$baseApi/get-products-by-sellerId/$sellerId";
  }

  static String productDeleteUrl(String productId, String sellerId) {
    return "$baseApi/api/product/$productId?sellerId=$sellerId";
  }

  static String getTotalReceivedLeadsURL(String sellerId) {
    return "$baseApi/get-total-rfqs/$sellerId";
  }

  static String updateRfqStatusUrl(String rfqId) {
    return "$baseApi/update-rfq-status/$rfqId";
  }

  static String fetchUserAnalyticsUrl(String sellerId) {
    return "$baseApi/rfq/status-counts/seller/$sellerId";
  }
}
