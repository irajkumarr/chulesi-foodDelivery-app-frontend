import 'package:chulesi/core/utils/popups/toast.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlLaunch {
  static void launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showToast('Could not launch $url');
      // throw 'Could not launch $url';
    }
  }
}
