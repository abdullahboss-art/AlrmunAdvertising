import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class _AdvertisingEstimatePageState extends State<AdvertisingEstimatePage>
    with SingleTickerProviderStateMixin {
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

  final ScrollController _scrollController = ScrollController();

  // =========================================================
  // QUANTITY FIELD KEY
  // =========================================================

  final GlobalKey _quantityKey = GlobalKey();



  final TextEditingController _quantityController =
      TextEditingController();

  final TextEditingController _widthController =
      TextEditingController();

  final TextEditingController _heightController =
      TextEditingController();

  // =========================================================
  // WHATSAPP ANIMATION
  // =========================================================

  late AnimationController _whatsappAnimationController;
  late Animation<double> _whatsappAnimation;

  // =========================================================
  // VARIABLES
  // =========================================================

  String? selectedCategory;

  String selectedUnit = 'Feet (ft)';

  bool withInstallation = false;

  bool submitted = false;

  // =========================================================
  // INIT STATE
  // =========================================================

  @override
  void initState() {
    super.initState();

    // ---------------------------------------------------------
    // WHATSAPP FLOATING ANIMATION
    // ---------------------------------------------------------

    _whatsappAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1800,
      ),
    );

    _whatsappAnimation = Tween<double>(
      begin: -6,
      end: 6,
    ).animate(
      CurvedAnimation(
        parent: _whatsappAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _whatsappAnimationController.repeat(
      reverse: true,
    );
  }

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
  // WHATSAPP FLOATING BUTTON
  // =========================================================

  Widget _buildWhatsAppFloatingButton() {
    return AnimatedBuilder(
      animation: _whatsappAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            _whatsappAnimation.value,
          ),
          child: child,
        );
      },
      child: GestureDetector(
        onTap: openWhatsApp,
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF25D366),
            boxShadow: [
              BoxShadow(
                color:
                    const Color(0xFF25D366)
                        .withOpacity(0.45),
                blurRadius: 18,
                spreadRadius: 2,
              ),
            ],
            border: Border.all(
              color:
                  Colors.white.withOpacity(0.20),
              width: 1,
            ),
          ),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.whatsapp,
              color: Colors.white,
              size: 31,
            ),
          ),
        ),
      ),
    );
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
    _whatsappAnimationController.dispose();

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
        child: Stack(
          children: [
            // =================================================
            // MAIN SCROLL CONTENT
            // =================================================

            SingleChildScrollView(
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
                    // =========================================
                    // HEADER
                    // =========================================

                    const EstimateHeader(),

                    const SizedBox(
                      height: 22,
                    ),

                    // =========================================
                    // REQUIREMENTS CARD
                    // =========================================

                    RequirementsCard(
                      selectedCategory:
                          selectedCategory,

                      selectedUnit:
                          selectedUnit,

                      withInstallation:
                          withInstallation,

                      // ---------------------------------------
                      // CONTROLLERS
                      // ---------------------------------------

                      quantityController:
                          _quantityController,

                      widthController:
                          _widthController,

                      heightController:
                          _heightController,

                      // ---------------------------------------
                      // CATEGORY
                      // ---------------------------------------

                      onCategoryChanged:
                          (value) {
                        setState(() {
                          selectedCategory =
                              value;

                          submitted =
                              false;
                        });
                      },

                      // ---------------------------------------
                      // UNIT
                      // ---------------------------------------

                      onUnitChanged:
                          (value) {
                        setState(() {
                          selectedUnit =
                              value;

                          submitted =
                              false;
                        });
                      },

                      // ---------------------------------------
                      // INSTALLATION
                      // ---------------------------------------

                      onInstallationChanged:
                          (value) {
                        setState(() {
                          withInstallation =
                              value;

                          submitted =
                              false;
                        });
                      },

                      // ---------------------------------------
                      // CALCULATE
                      // ---------------------------------------

                      onCalculate:
                          calculateEstimate,

                      // ---------------------------------------
                      // SCROLL CONTROLLER
                      // ---------------------------------------

                      scrollController:
                          _scrollController,

                      // ---------------------------------------
                      // QUANTITY KEY
                      // ---------------------------------------

                      quantityKey:
                          _quantityKey,
                    ),

                    // =========================================
                    // RESULT
                    // =========================================

                    if (submitted) ...[
                      const SizedBox(
                        height: 18,
                      ),

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

                    // Extra bottom space so floating button
                    // doesn't cover the last content.
                    const SizedBox(
                      height: 45,
                    ),
                  ],
                ),
              ),
            ),

            // =================================================
            // WHATSAPP FLOATING BUTTON
            // =================================================

            Positioned(
              right: 18,
              bottom: 20,
              child:
                  _buildWhatsAppFloatingButton(),
            ),
          ],
        ),
      ),
    );
  }
}