import 'package:url_launcher/url_launcher.dart';

class Call {
  Call({required this.phoneNumber});
  final String phoneNumber;
  Future<void> makeCall() async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $callUri';
    }
  }
}
