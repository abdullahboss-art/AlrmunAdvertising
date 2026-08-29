import 'package:flutter/material.dart';

class QuoteHelpers {
static const Color accent = Color(0xFF2D6A75);
  static const Color cardBg = Color(0xff161616);
  static const Color fieldBg = Color(0xff1D1D1D);
  static const Color border = Color(0xff2A2A2A);

  static String value(TextEditingController controller) {
    return controller.text.trim();
  }

  static String requestId() {
    final now = DateTime.now();

    return 'QR-${now.year}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}-'
        '${now.millisecondsSinceEpoch.toString().substring(7)}';
  }

  static String formattedDate() {
    final now = DateTime.now();

    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${now.day} ${months[now.month - 1]} ${now.year}';
  }
}