import 'package:pakmart/Model/RFQModel.dart';
import 'package:pakmart/SellerCentral/data/app_url/app_url.dart';
import 'package:pakmart/SellerCentral/data/network/network_services.dart';
import 'package:pakmart/service/session_manager/session_controller.dart';

abstract class ReceiveLeadsRepository {
  Future<List<RFQ>> fetchReceivedLeads();
  Future<String> updateLeadStatus(String rfqId, String status);
}

class ReceiveLeadsHttpRepository implements ReceiveLeadsRepository {
  NetworkServicesApi networkServicesApi = NetworkServicesApi();
  @override
  Future<List<RFQ>> fetchReceivedLeads() async {
    final sellerId = SellerSessionController().seller_id;
    final url = AppUrl.getTotalReceivedLeadsURL(sellerId);

    final response = await networkServicesApi.getApi(url);

    final List jsonLeads = response['rfqs'];
    return jsonLeads
        .map<RFQ>((jsonObj) => RFQ.fromJson(jsonObj))
        .toList()
        .cast<RFQ>();
  }

  @override
  Future<String> updateLeadStatus(String rfqId, String status) async {
    final url = AppUrl.updateRfqStatusUrl(rfqId);

    final response = await networkServicesApi.updateApi(url, {
      'status': status,
    });

    return response['message'];
  }
}
