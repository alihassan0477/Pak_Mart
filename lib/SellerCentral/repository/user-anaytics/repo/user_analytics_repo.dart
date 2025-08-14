import 'package:pakmart/SellerCentral/data/app_url/app_url.dart';
import 'package:pakmart/SellerCentral/data/network/network_services.dart';
import 'package:pakmart/SellerCentral/repository/user-anaytics/model/user_analytics_model.dart';
import 'package:pakmart/service/session_manager/session_controller.dart';

abstract class UserAnalyticsRepo {
  Future<UserAnalyticsModel> fetchUserAnalytics();
}

class UserAnalyticsRepoHttp implements UserAnalyticsRepo {
  @override
  Future<UserAnalyticsModel> fetchUserAnalytics() async {
    final sellerId = SellerSessionController().seller_id;
    final url = AppUrl.fetchUserAnalyticsUrl(sellerId);

    final response = await NetworkServicesApi().getApi(url);

    return UserAnalyticsModel.fromJson(response['statusCounts']);
  }
}
