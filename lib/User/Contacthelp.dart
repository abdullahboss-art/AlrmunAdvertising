import 'package:url_launcher/url_launcher.dart';

class ContactHelpers {
  // =========================================================
  // CONTACT DETAILS
  // =========================================================

  static const String phone =
      '+971 50 123 4567';

  static const String email =
      'info@alrmanad.com';

  static const String location =
      'Dubai, United Arab Emirates';

  static const String website =
      'https://www.alrmanadvertising.com';

  // =========================================================
  // SOCIAL LINKS
  // =========================================================

  static const String facebookUrl =
      'https://facebook.com/alrmanadvertising';

  static const String instagramUrl =
      'https://instagram.com/alrmanadvertising';

  static const String linkedInUrl =
      'https://linkedin.com/company/alrmanadvertising';

  static const String youtubeUrl =
      'https://youtube.com/@alrmanadvertising';

  // =========================================================
  // OPEN URL
  // =========================================================

  static Future<void> openUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (_) {
      // Ignore URL launch errors.
    }
  }

  // =========================================================
  // CALL
  // =========================================================

  static Future<void> callUs() async {
    final String number = phone.replaceAll(
      RegExp(r'[^0-9+]'),
      '',
    );

    await openUrl(
      'tel:$number',
    );
  }

  // =========================================================
  // EMAIL
  // =========================================================

  static Future<void> emailUs() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Inquiry - Alrman Advertising',
        'body':
            'Hello Alrman Advertising,\n\n'
            'I would like to know more about your services.\n\n'
            'Thank you.',
      },
    );

    await openUrl(
      emailUri.toString(),
    );
  }

  // =========================================================
  // LOCATION
  // =========================================================

  static Future<void> openLocation() async {
    final String query =
        Uri.encodeComponent(location);

    await openUrl(
      'https://www.google.com/maps/search/'
      '?api=1&query=$query',
    );
  }

  // =========================================================
  // WEBSITE
  // =========================================================

  static Future<void> openWebsite() async {
    await openUrl(website);
  }

  // =========================================================
  // WHATSAPP
  // =========================================================

  static Future<void> openWhatsApp() async {
    final String number = phone.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    final String message =
        Uri.encodeComponent(
      'Hello Alrman Advertising, '
      'I would like to know more about your services.',
    );

    await openUrl(
      'https://wa.me/$number?text=$message',
    );
  }

  // =========================================================
  // FACEBOOK
  // =========================================================

  static Future<void> openFacebook() async {
    await openUrl(facebookUrl);
  }

  // =========================================================
  // INSTAGRAM
  // =========================================================

  static Future<void> openInstagram() async {
    await openUrl(instagramUrl);
  }

  // =========================================================
  // LINKEDIN
  // =========================================================

  static Future<void> openLinkedIn() async {
    await openUrl(linkedInUrl);
  }

  // =========================================================
  // YOUTUBE
  // =========================================================

  static Future<void> openYouTube() async {
    await openUrl(youtubeUrl);
  }
}