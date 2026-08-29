import 'package:flutter/material.dart';
import 'quote_helpers.dart';

class QuoteWidgets {
  static Widget fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static InputDecoration fieldDecoration({
    required IconData icon,
    String? hint,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.white38,
        fontSize: 14,
      ),
      prefixIcon: Icon(
        icon,
        color: QuoteHelpers.accent,
        size: 20,
      ),
      filled: true,
      fillColor: QuoteHelpers.fieldBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: QuoteHelpers.border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: QuoteHelpers.border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: QuoteHelpers.accent,
          width: 1.2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
    );
  }

  static Widget formField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fieldLabel(label),
          TextFormField(
            controller: controller,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            keyboardType: keyboardType,
            decoration: fieldDecoration(
              icon: icon,
              hint: hint,
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }

  static Widget dropdownField({
    required String label,
    required String? value,
    required List<String> options,
    required IconData icon,
    required String hint,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fieldLabel(label),
          DropdownButtonFormField<String>(
            initialValue: value,
            isExpanded: true,
            dropdownColor: QuoteHelpers.fieldBg,
            icon: const Icon(
              Icons.keyboard_arrow_down,
             color: const Color(0xFF2D6A75),
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: fieldDecoration(
              icon: icon,
              hint: hint,
            ),
            items: options.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: onChanged,
            validator: validator,
          ),
        ],
      ),
    );
  }

  static Widget toggleField({
    required String label,
    required bool value,
    required String trueLabel,
    required String falseLabel,
    required void Function(bool) onChanged,
  }) {
    Widget option({
      required bool selected,
      required String text,
      required VoidCallback onTap,
    }) {
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: QuoteHelpers.fieldBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected
                    ? QuoteHelpers.accent
                    : QuoteHelpers.border,
                width: selected ? 1.4 : 1,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.white54,
                fontSize: 13.5,
                fontWeight: selected
                    ? FontWeight.bold
                    : FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fieldLabel(label),
          Row(
            children: [
              option(
                selected: !value,
                text: falseLabel,
                onTap: () => onChanged(false),
              ),
              const SizedBox(width: 12),
              option(
                selected: value,
                text: trueLabel,
                onTap: () => onChanged(true),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget sectionCard({
    required String title,
    String? subtitle,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: QuoteHelpers.cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: QuoteHelpers.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }

  static Widget summaryRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not provided' : value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}