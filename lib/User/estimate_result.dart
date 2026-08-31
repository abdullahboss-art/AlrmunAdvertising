import 'package:flutter/material.dart';
import 'estimate_data.dart';

class EstimateResultCard extends StatelessWidget {
  final GlobalKey resultKey;

  final String? selectedCategory;
  final double quantity;

  final String width;
  final String height;
  final String selectedUnit;

  final double area;
  final double printingCost;
  final double installationCost;
  final double totalPrice;

  final VoidCallback onWhatsApp;

  const EstimateResultCard({
    super.key,
    required this.resultKey,
    required this.selectedCategory,
    required this.quantity,
    required this.width,
    required this.height,
    required this.selectedUnit,
    required this.area,
    required this.printingCost,
    required this.installationCost,
    required this.totalPrice,
    required this.onWhatsApp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: resultKey,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EstimateColors.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: EstimateColors.accent.withOpacity(0.30),
        ),
        boxShadow: [
          BoxShadow(
            color: EstimateColors.accent.withOpacity(0.05),
            blurRadius: 25,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: EstimateColors.accent.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.receipt_long_outlined,
                  color: EstimateColors.accent,
                  size: 17,
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'YOUR ESTIMATE',
                    style: TextStyle(
                      color: EstimateColors.accent,
                      fontSize: 8,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Estimated Cost',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 15),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 19,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: EstimateColors.fieldColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: EstimateColors.accent.withOpacity(0.18),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'ESTIMATED TOTAL',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 7.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                FittedBox(
                  child: Text(
                    'AED ${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: EstimateColors.accent,
                      fontSize: 27,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          EstimateSummaryRow(
            title: 'Printing Type',
            value: selectedCategory ?? '—',
          ),

          EstimateSummaryRow(
            title: 'Quantity',
            value: quantity.toStringAsFixed(0),
          ),

          EstimateSummaryRow(
            title: 'Size',
            value: '$width × $height $selectedUnit',
          ),

          EstimateSummaryRow(
            title: 'Total Area',
            value: '${area.toStringAsFixed(2)} sq ft',
          ),

          EstimateSummaryRow(
            title: 'Printing Cost',
            value: 'AED ${printingCost.toStringAsFixed(2)}',
          ),

          EstimateSummaryRow(
            title: 'Installation',
            value: 'AED ${installationCost.toStringAsFixed(2)}',
          ),

          const SizedBox(height: 5),

          Container(
            width: double.infinity,
            height: 1,
            color: EstimateColors.borderColor,
          ),

          const SizedBox(height: 13),

          const Text(
            'This is an estimated price. Final pricing may depend on material, design and project requirements.',
            style: TextStyle(
              color: Colors.white30,
              fontSize: 8,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: onWhatsApp,
              icon: const Icon(
                Icons.chat_rounded,
                color: Colors.white,
                size: 18,
              ),
              label: const Text(
                'ORDER NOW ON WHATSAPP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF20B85A),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 9),

          const Center(
            child: Text(
              'Your estimate will be sent to our team through WhatsApp.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white24,
                fontSize: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EstimateSummaryRow extends StatelessWidget {
  final String title;
  final String value;

  const EstimateSummaryRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 9,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}