import 'package:flutter/material.dart';

class ContactWidgets {
  // =========================================================
  // CONTACT CARD
  // =========================================================

  static Widget contactCard({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 118,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF171B24),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF20242B),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 19,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 9.5,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // INPUT FIELD
  // =========================================================

  static Widget inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.5,
          ),
          cursorColor: const Color(0xFF36B6BD),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.white38,
              fontSize: 12,
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.white54,
              size: 18,
            ),
            filled: true,
            fillColor: const Color(0xFF141820),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 13,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(
              color: errorText != null
    ? const Color(0xFF36B6BD)
    : const Color(0xFF36B6BD),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(
                color: errorText != null
    ? const Color(0xFF36B6BD)
    : const Color(0xFF36B6BD),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide(
               color: errorText != null
    ? const Color(0xFF36B6BD)
    : const Color(0xFF36B6BD),
                width: 1.2,
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              errorText,
              style: const TextStyle(
                color:  Color(0xFF36B6BD),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  // =========================================================
  // SOCIAL BUTTON
  // =========================================================

  static Widget socialButton(
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.15),
          border: Border.all(
            color: color.withOpacity(0.35),
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            color: color,
            size: 19,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // SOCIAL IMAGE BUTTON
  // =========================================================

  static Widget socialImageButton(
    String assetPath,
    Color color,
    Future<void> Function() onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.15),
          border: Border.all(
            color: color.withOpacity(0.35),
          ),
        ),
        child: Center(
          child: Image.asset(
            assetPath,
            width: 20,
            height: 20,
            fit: BoxFit.contain,
            errorBuilder: (
              BuildContext context,
              Object error,
              StackTrace? stackTrace,
            ) {
              return Icon(
                Icons.public,
                color: color,
                size: 19,
              );
            },
          ),
        ),
      ),
    );
  }
}