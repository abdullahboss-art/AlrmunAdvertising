
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'estimate_data.dart';
import 'estimate_form.dart';
import 'estimate_result.dart';

class AdvertisingEstimatePage extends StatefulWidget {
  const AdvertisingEstimatePage({super.key});

  @override
  State<AdvertisingEstimatePage> createState() =>
      _AdvertisingEstimatePageState();
}

class _AdvertisingEstimatePageState
    extends State<AdvertisingEstimatePage> {

  // =========================================================
  // FORM KEY
  // =========================================================

  final _formKey = GlobalKey<FormState>();

  // =========================================================
  // RESULT KEY
  // =========================================================

  final GlobalKey _resultKey = GlobalKey();

  // =========================================================
  // SCROLL CONTROLLER
  // =========================================================

  final ScrollController _scrollController =
      ScrollController();

  // =========================================================
  // QUANTITY FIELD KEY
  // =========================================================

  final GlobalKey _quantityKey = GlobalKey();

  // =========================================================
  // TEXT CONTROLLERS
  // =========================================================

  final TextEditingController _quantityController =
      TextEditingController();

  final TextEditingController _widthController =
      TextEditingController();

  final TextEditingController _heightController =
      TextEditingController();

  // =========================================================
  // VARIABLES
  // =========================================================

  String? selectedCategory;

  String selectedUnit = 'Feet (ft)';

  bool withInstallation = false;

  bool submitted = false;

  // =========================================================
  // CALCULATIONS
  // =========================================================

  double get quantity =>
      double.tryParse(
        _quantityController.text.trim(),
      ) ??
      0;

  double get width =>
      double.tryParse(
        _widthController.text.trim(),
      ) ??
      0;

  double get height =>
      double.tryParse(
        _heightController.text.trim(),
      ) ??
      0;

  // =========================================================
  // CONVERT TO FEET
  // =========================================================

  double convertToFeet(double value) {
    switch (selectedUnit) {
      case 'Centimeters (cm)':
        return value / 30.48;

      case 'Inches (in)':
        return value / 12;

      case 'Feet (ft)':
        return value;

      default:
        return value;
    }
  }

  // =========================================================
  // WIDTH IN FEET
  // =========================================================

  double get widthInFeet =>
      convertToFeet(width);

  // =========================================================
  // HEIGHT IN FEET
  // =========================================================

  double get heightInFeet =>
      convertToFeet(height);

  // =========================================================
  // AREA
  // =========================================================

  double get area =>
      widthInFeet * heightInFeet;

  // =========================================================
  // SELECTED RATE
  // =========================================================

  double get selectedRate {
    if (selectedCategory == null) {
      return 0;
    }

    final category =
        advertisingCategories.firstWhere(
      (item) =>
          item['title'] == selectedCategory,
    );

    return category['rate'] as double;
  }

  // =========================================================
  // INSTALLATION COST
  // =========================================================

  double get installationCost {
    if (!withInstallation) {
      return 0;
    }

    return area * quantity * 10;
  }

  // =========================================================
  // PRINTING COST
  // =========================================================

  double get printingCost =>
      area * quantity * selectedRate;

  // =========================================================
  // TOTAL PRICE
  // =========================================================

  double get totalPrice =>
      printingCost + installationCost;

  // =========================================================
  // CALCULATE ESTIMATE
  // =========================================================

  void calculateEstimate() {
    // ---------------------------------------------------------
    // CHECK CATEGORY
    // ---------------------------------------------------------

    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor:
              EstimateColors.cardColor,

          behavior:
              SnackBarBehavior.floating,

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),

          content: const Row(
            children: [
              Icon(
                Icons.info_outline,
                color:
                    EstimateColors.accent,
              ),

              SizedBox(width: 10),

              Expanded(
                child: Text(
                  'Please select a printing service first.',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      return;
    }

    // ---------------------------------------------------------
    // VALIDATE FORM
    // ---------------------------------------------------------

    if (!_formKey.currentState!.validate()) {
      return;
    }

    // ---------------------------------------------------------
    // HIDE KEYBOARD
    // ---------------------------------------------------------

    FocusScope.of(context).unfocus();

    // ---------------------------------------------------------
    // SHOW RESULT
    // ---------------------------------------------------------

    setState(() {
      submitted = true;
    });

    // ---------------------------------------------------------
    // SCROLL TO RESULT
    // ---------------------------------------------------------

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!mounted) return;

        final resultContext =
            _resultKey.currentContext;

        if (resultContext != null) {
          Scrollable.ensureVisible(
            resultContext,

            duration:
                const Duration(
              milliseconds: 700,
            ),

            curve:
                Curves.easeInOutCubic,

            alignment: 0.04,
          );
        }
      },
    );
  }

  // =========================================================
  // WHATSAPP MESSAGE
  // =========================================================

  String get whatsappMessage {
    return '''
Hello, I would like to request an advertising estimate.

Service: ${selectedCategory ?? ''}

Quantity: ${_quantityController.text.trim()}

Width: ${_widthController.text.trim()} $selectedUnit

Height: ${_heightController.text.trim()} $selectedUnit

Total Area: ${area.toStringAsFixed(2)} sq ft

Installation: ${withInstallation ? 'With Installation' : 'Without Installation'}

Printing Cost: AED ${printingCost.toStringAsFixed(2)}

Installation Cost: AED ${installationCost.toStringAsFixed(2)}

Estimated Total: AED ${totalPrice.toStringAsFixed(2)}

Thank you.
''';
  }

  // =========================================================
  // OPEN WHATSAPP
  // =========================================================

  Future<void> openWhatsApp() async {
    final message =
        Uri.encodeComponent(
      whatsappMessage,
    );

    final uri = Uri.parse(
      'https://wa.me/$whatsappNumber?text=$message',
    );

    try {
      final launched =
          await launchUrl(
        uri,
        mode:
            LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        _showMessage(
          'Could not open WhatsApp.',
        );
      }
    } catch (_) {
      if (!mounted) return;

      _showMessage(
        'Could not open WhatsApp.',
      );
    }
  }

  // =========================================================
  // SHOW MESSAGE
  // =========================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _scrollController.dispose();

    _quantityController.dispose();

    _widthController.dispose();

    _heightController.dispose();

    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          EstimateColors.background,

      // =======================================================
      // APP BAR
      // =======================================================

      appBar: AppBar(
        backgroundColor:
            EstimateColors.background,

        elevation: 0,

        scrolledUnderElevation: 0,

        centerTitle: false,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,

            color: Colors.white,

            size: 19,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Get Your Estimate',

          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight:
                FontWeight.w700,
          ),
        ),
      ),

      // =======================================================
      // BODY
      // =======================================================

      body: SafeArea(
        child: SingleChildScrollView(
          // IMPORTANT
          // Same controller is passed to RequirementsCard
          controller:
              _scrollController,

          physics:
              const BouncingScrollPhysics(),

          padding:
              const EdgeInsets.fromLTRB(
            16,
            8,
            16,
            40,
          ),

          child: Form(
            key: _formKey,

            child: Column(
              children: [
                // =================================================
                // HEADER
                // =================================================

                const EstimateHeader(),

                const SizedBox(height: 22),

                // =================================================
                // REQUIREMENTS CARD
                // =================================================

                RequirementsCard(
                  selectedCategory:
                      selectedCategory,

                  selectedUnit:
                      selectedUnit,

                  withInstallation:
                      withInstallation,

                  // ------------------------------------------------
                  // CONTROLLERS
                  // ------------------------------------------------

                  quantityController:
                      _quantityController,

                  widthController:
                      _widthController,

                  heightController:
                      _heightController,

                  // ------------------------------------------------
                  // CATEGORY
                  // ------------------------------------------------

                  onCategoryChanged:
                      (value) {
                    setState(() {
                      selectedCategory =
                          value;

                      submitted = false;
                    });
                  },

                  // ------------------------------------------------
                  // UNIT
                  // ------------------------------------------------

                  onUnitChanged:
                      (value) {
                    setState(() {
                      selectedUnit =
                          value;

                      submitted = false;
                    });
                  },

                  // ------------------------------------------------
                  // INSTALLATION
                  // ------------------------------------------------

                  onInstallationChanged:
                      (value) {
                    setState(() {
                      withInstallation =
                          value;

                      submitted = false;
                    });
                  },

                  // ------------------------------------------------
                  // CALCULATE
                  // ------------------------------------------------

                  onCalculate:
                      calculateEstimate,

                  // ------------------------------------------------
                  // SCROLL CONTROLLER
                  // ------------------------------------------------

                  scrollController:
                      _scrollController,

                  // ------------------------------------------------
                  // QUANTITY KEY
                  // ------------------------------------------------

                  quantityKey:
                      _quantityKey,
                ),

                // =================================================
                // RESULT
                // =================================================

                if (submitted) ...[
                  const SizedBox(height: 18),

                  EstimateResultCard(
                    key: _resultKey,

                    resultKey:
                        _resultKey,

                    selectedCategory:
                        selectedCategory,

                    quantity:
                        quantity,

                    width:
                        _widthController
                            .text
                            .trim(),

                    height:
                        _heightController
                            .text
                            .trim(),

                    selectedUnit:
                        selectedUnit,

                    area:
                        area,

                    printingCost:
                        printingCost,

                    installationCost:
                        installationCost,

                    totalPrice:
                        totalPrice,

                    onWhatsApp:
                        openWhatsApp,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

