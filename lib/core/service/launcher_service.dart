import 'package:url_launcher/url_launcher.dart';

import '../exceptions/launcher_exception.dart';

abstract class LauncherService {
  Future<void> callPhone(String phoneNumber);
  Future<void> openWhatsappChat({String? phoneNumber, String? message});
  Future<void> openWebsite(String url);
  Future<void> openGoogleMaps(String url);
  Future<void> sendEmail(String email, [String? emailSubject, String? message]);
}

class LauncherServiceImpl extends LauncherService {
  @override
  Future<void> callPhone(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    final result = await canLaunchUrl(uri);
    if (result)
      await launchUrl(uri);
    else
      throw LauncherException();
  }

  @override
  Future<void> openWebsite(String url) async {
    final uri = Uri.parse(url.trim());

    final result = await canLaunchUrl(uri);
    if (result)
      await launchUrl(uri);
    else
      throw LauncherException();
  }

  @override
  Future<void> openWhatsappChat({String? phoneNumber, String? message}) async {
    var url = 'whatsapp://send';

    final linkAttributesList = <String>[];
    if (phoneNumber != null) linkAttributesList.add('phone=$phoneNumber');

    if (message != null) linkAttributesList.add(_createMessage(message));

    if (linkAttributesList.isNotEmpty)
      url = '$url?${linkAttributesList.join('&')}';

    final uri = Uri.parse(url);

    final result = await canLaunchUrl(uri);
    if (result)
      await launchUrl(uri);
    else
      throw LauncherException();
  }

  String _createMessage(String message) => message.contains('http')
      ? 'text=${Uri.encodeComponent(message)}'
      : 'text=$message';

  @override
  Future<void> sendEmail(
    String email, [
    String? emailSubject,
    String? message,
  ]) async {
    final uri = Uri.parse('mailto:$email');

    final result = await canLaunchUrl(uri);
    if (result)
      await launchUrl(uri);
    else
      throw LauncherException();
  }

  @override
  Future<void> openGoogleMaps(String url) async {
    final uri = Uri.parse(url);

    final result = await canLaunchUrl(uri);
    if (result)
      await launchUrl(uri);
    else
      throw LauncherException();
  }
}
