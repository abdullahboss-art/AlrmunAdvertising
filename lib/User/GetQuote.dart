import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'quote_helpers.dart';
import 'quote_widgets.dart';

class GetAQuotePage extends StatefulWidget {
  final String serviceTitle;

  const GetAQuotePage({
    super.key,
    required this.serviceTitle,
  });

  @override
  State<GetAQuotePage> createState() => _GetAQuotePageState();
}

class _GetAQuotePageState extends State<GetAQuotePage> {
  // =========================================================
  // THEME
  // =========================================================

  static const Color bg = Color(0xff07131B);
  static const Color card = Color(0xff0D1B24);
  static const Color field = Color(0xff08151D);
  static const Color cyan = Color(0xff2D6A75);

  // =========================================================
  // WHATSAPP
  // =========================================================

  static const String whatsappNumber = '923152635232';

  // =========================================================
  // FORM CONTROLLERS
  // =========================================================

  final _formKey = GlobalKey<FormState>();
  final _resultKey = GlobalKey();
  final _scrollController = ScrollController();

  final _quantity = TextEditingController();
  final _width = TextEditingController();
  final _height = TextEditingController();

  // =========================================================
  // MEASUREMENT UNITS
  // =========================================================

  static const List<String> units = [
    'Inches (in)',
    'Feet (ft)',
    'Centimeters (cm)',
  ];

  String? selectedUnit = 'Feet (ft)';

  // =========================================================
  // OPTIONS
  // =========================================================

  bool installation = true;
  bool submitted = false;

  // =========================================================
  // PRICING
  // =========================================================

  static const double baseRate = 25.0;
  static const double installationRate = 10.0;

  // =========================================================
  // INPUT VALUES
  // =========================================================

  double get width =>
      double.tryParse(_width.text.trim()) ?? 0;

  double get height =>
      double.tryParse(_height.text.trim()) ?? 0;

  // =========================================================
  // CONVERT TO FEET
  // =========================================================

  double toFeet(double value) {
    switch (selectedUnit) {
      case 'Inches (in)':
        return value / 12;

      case 'Centimeters (cm)':
        return value / 30.48;

      case 'Feet (ft)':
      default:
        return value;
    }
  }

  // =========================================================
  // CALCULATIONS
  // =========================================================

  double get widthInFeet => toFeet(width);

  double get heightInFeet => toFeet(height);

  double get area =>
      widthInFeet * heightInFeet;

  double get basePrice =>
      area * baseRate;

  double get installationTotal =>
      installation
          ? area * installationRate
          : 0.0;

  double get total =>
      basePrice + installationTotal;

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _quantity.dispose();
    _width.dispose();
    _height.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  // =========================================================
  // SUBMIT REQUEST
  // =========================================================

  void submitRequest() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      submitted = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final resultContext =
          _resultKey.currentContext;

      if (resultContext != null) {
        Scrollable.ensureVisible(
          resultContext,
          duration:
              const Duration(milliseconds: 600),
          curve:
              Curves.easeInOut,
          alignment: 0.05,
        );
      }
    });
  }

  // =========================================================
  // WHATSAPP MESSAGE
  // =========================================================

  String get whatsappMessage => '''
Hello ALRMAN Advertising Team,

I would like to request a quotation for my project.

━━━━━━━━━━━━━━━━━━━━
PROJECT DETAILS
━━━━━━━━━━━━━━━━━━━━

Service:
${widget.serviceTitle}

Quantity:
${_quantity.text.trim()}

Width:
${_width.text.trim()} ${selectedUnit ?? ''}

Height:
${_height.text.trim()} ${selectedUnit ?? ''}

Measurement Unit:
${selectedUnit ?? ''}

Installation:
${installation ? 'With Installation' : 'Without Installation'}

━━━━━━━━━━━━━━━━━━━━
QUOTATION DETAILS
━━━━━━━━━━━━━━━━━━━━

Area:
${area.toStringAsFixed(2)} sq ft

Base Rate:
AED ${baseRate.toStringAsFixed(2)} / sq ft

Base Price:
AED ${basePrice.toStringAsFixed(2)}

Installation Rate:
AED ${installationRate.toStringAsFixed(2)} / sq ft

Installation Total:
AED ${installationTotal.toStringAsFixed(2)}

━━━━━━━━━━━━━━━━━━━━
TOTAL PRICE
━━━━━━━━━━━━━━━━━━━━

AED ${total.toStringAsFixed(2)}

━━━━━━━━━━━━━━━━━━━━
REQUEST DETAILS
━━━━━━━━━━━━━━━━━━━━

Request ID:
${QuoteHelpers.requestId()}

I would like to discuss this project further and confirm the quotation.

Thank you,
ALRMAN Advertising
''';

  // =========================================================
  // OPEN WHATSAPP
  // =========================================================

  Future<void> openWhatsApp() async {
    final uri = Uri.parse(
      'https://wa.me/$whatsappNumber?text=${Uri.encodeComponent(whatsappMessage)}',
    );

    try {
      final opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not open WhatsApp.',
            ),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not open WhatsApp.',
          ),
        ),
      );
    }
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,

      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,

        iconTheme: const IconThemeData(
          color: Colors.white,
        ),

        title: const Text(
          'Get a Quote',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,

          padding: const EdgeInsets.fromLTRB(
            18,
            10,
            18,
            30,
          ),

          child: Form(
            key: _formKey,

            child: Column(
              children: [
                buildForm(),

                if (submitted) ...[
                  const SizedBox(height: 18),
                  buildResult(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // FORM
  // =========================================================

  Widget buildForm() {
    return QuoteWidgets.sectionCard(
      title: 'Your Requirements',

      subtitle:
          'Select your service and enter the required details.',

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // =================================================
          // SERVICE
          // =================================================

          selectedService(),

          // =================================================
          // QUANTITY
          // =================================================

          QuoteWidgets.formField(
            label: 'Quantity',
            controller: _quantity,

            icon:
                Icons.production_quantity_limits,

            hint: 'Enter quantity',

            keyboardType:
                TextInputType.number,

            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty) {
                return 'Please enter quantity';
              }

              return null;
            },
          ),

          // =================================================
          // WIDTH + HEIGHT
          // =================================================

          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Expanded(
                child: QuoteWidgets.formField(
                  label: 'Width',
                  controller: _width,

                  icon:
                      Icons.straighten_outlined,

                  hint: 'e.g. 10',

                  keyboardType:
                      const TextInputType.numberWithOptions(
                    decimal: true,
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Enter width';
                    }

                    if (double.tryParse(
                          value.trim(),
                        ) ==
                        null) {
                      return 'Enter valid width';
                    }

                    return null;
                  },
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: QuoteWidgets.formField(
                  label: 'Height',
                  controller: _height,

                  icon:
                      Icons.height_outlined,

                  hint: 'e.g. 5',

                  keyboardType:
                      const TextInputType.numberWithOptions(
                    decimal: true,
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Enter height';
                    }

                    if (double.tryParse(
                          value.trim(),
                        ) ==
                        null) {
                      return 'Enter valid height';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),

          // =================================================
          // MEASUREMENT UNIT
          // =================================================

          QuoteWidgets.dropdownField(
            label: 'Measurement Unit',

            value: selectedUnit,

            options: units,

            icon:
                Icons.square_foot_outlined,

            hint:
                'Select measurement unit',

            onChanged: (value) {
              setState(() {
                selectedUnit = value;
              });
            },

            validator: (value) {
              if (value == null ||
                  value.isEmpty) {
                return 'Select measurement unit';
              }

              return null;
            },
          ),

          // =================================================
          // INSTALLATION
          // =================================================

          QuoteWidgets.toggleField(
            label: 'Installation',

            value: installation,

            trueLabel:
                'With Installation',

            falseLabel:
                'Without Installation',

            onChanged: (value) {
              setState(() {
                installation = value;
              });
            },
          ),

          const SizedBox(height: 4),

          // =================================================
          // SUBMIT
          // =================================================

          SizedBox(
            width: double.infinity,
            height: 54,

            child: ElevatedButton(
              onPressed: submitRequest,

              style:
                  ElevatedButton.styleFrom(
                backgroundColor: cyan,
                foregroundColor: Colors.white,

                elevation: 0,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
              ),

              child: const Text(
                'SUBMIT REQUEST',

                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                      FontWeight.bold,
                  letterSpacing: .5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SELECTED SERVICE
  // =========================================================

  Widget selectedService() {
    return Container(
      width: double.infinity,

      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),

      padding:
          const EdgeInsets.all(14),

      decoration:
          BoxDecoration(
        color: field,

        borderRadius:
            BorderRadius.circular(12),

        border:
            Border.all(
          color:
              cyan.withOpacity(.35),
        ),
      ),

      child: Row(
        children: [
          Container(
            padding:
                const EdgeInsets.all(9),

            decoration:
                BoxDecoration(
              color:
                  cyan.withOpacity(.10),

              borderRadius:
                  BorderRadius.circular(
                10,
              ),
            ),

            child: const Icon(
              Icons.design_services_outlined,
              color: cyan,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  'SELECTED SERVICE',

                  style: TextStyle(
                    color:
                        Colors.white54,

                    fontSize: 10,

                    fontWeight:
                        FontWeight.w600,

                    letterSpacing: .8,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  widget.serviceTitle,

                  style: const TextStyle(
                    color:
                        Colors.white,

                    fontSize: 15,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.check_circle,
            color: cyan,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // RESULT
  // =========================================================

  Widget buildResult() {
    return Container(
      key: _resultKey,

      width: double.infinity,

      padding:
          const EdgeInsets.all(18),

      decoration:
          BoxDecoration(
        color: card,

        borderRadius:
            BorderRadius.circular(18),

        border:
            Border.all(
          color:
              cyan.withOpacity(.35),
        ),

        boxShadow: [
          BoxShadow(
            color:
                cyan.withOpacity(.05),

            blurRadius: 20,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          // =================================================
          // RESULT TITLE
          // =================================================

          const Text(
            'YOUR QUOTATION',

            style: TextStyle(
              color:
                  Colors.white38,

              fontSize: 11,

              fontWeight:
                  FontWeight.w600,

              letterSpacing: .8,
            ),
          ),

          const SizedBox(height: 8),

          const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: cyan,
                size: 24,
              ),

              SizedBox(width: 9),

              Text(
                'Request Submitted',

                style: TextStyle(
                  color:
                      Colors.white,

                  fontSize: 19,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // =================================================
          // USER DETAILS
          // =================================================

          QuoteWidgets.summaryRow(
            'Quantity',
            _quantity.text.trim(),
          ),

          QuoteWidgets.summaryRow(
            'Service',
            widget.serviceTitle,
          ),

          QuoteWidgets.summaryRow(
            'Width',
            '${_width.text.trim()} $selectedUnit',
          ),

          QuoteWidgets.summaryRow(
            'Height',
            '${_height.text.trim()} $selectedUnit',
          ),

          QuoteWidgets.summaryRow(
            'Unit',
            selectedUnit ?? '',
          ),

          QuoteWidgets.summaryRow(
            'Installation',
            installation
                ? 'With Installation'
                : 'Without Installation',
          ),

          const Divider(
            color:
                Colors.white12,

            height: 28,
          ),

          // =================================================
          // AREA
          // =================================================

          QuoteWidgets.summaryRow(
            'Area',
            '${area.toStringAsFixed(2)} sq ft',
          ),

          // =================================================
          // BASE RATE
          // =================================================

          QuoteWidgets.summaryRow(
            'Base Rate',
            'AED ${baseRate.toStringAsFixed(2)} / sq ft',
          ),

          // =================================================
          // BASE PRICE
          // =================================================

          QuoteWidgets.summaryRow(
            'Base Price',
            'AED ${basePrice.toStringAsFixed(2)}',
          ),

          // =================================================
          // INSTALLATION RATE
          // =================================================

          QuoteWidgets.summaryRow(
            'Installation Rate',
            'AED ${installationRate.toStringAsFixed(2)} / sq ft',
          ),

          // =================================================
          // INSTALLATION TOTAL
          // =================================================

          QuoteWidgets.summaryRow(
            'Installation Total',
            'AED ${installationTotal.toStringAsFixed(2)}',
          ),

          const SizedBox(height: 8),

          // =================================================
          // TOTAL PRICE
          // =================================================

          Container(
            width: double.infinity,

            padding:
                const EdgeInsets.all(16),

            decoration:
                BoxDecoration(
              color:
                  cyan.withOpacity(.10),

              borderRadius:
                  BorderRadius.circular(14),

              border:
                  Border.all(
                color:
                    cyan.withOpacity(.40),
              ),
            ),

            child: Column(
              children: [
                const Text(
                  'TOTAL PRICE',

                  style: TextStyle(
                    color:
                        Colors.white70,

                    fontSize: 12,

                    fontWeight:
                        FontWeight.w600,

                    letterSpacing: .8,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  'AED ${total.toStringAsFixed(2)}',

                  style: const TextStyle(
                    color: cyan,

                    fontSize: 23,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  installation
                      ? 'Base price + installation'
                      : 'Base price only',

                  style: const TextStyle(
                    color:
                        Colors.white54,

                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // =================================================
          // WHATSAPP BUTTON
          // =================================================

          SizedBox(
            width: double.infinity,

            height: 52,

            child:
                ElevatedButton.icon(
              onPressed:
                  openWhatsApp,

              icon:
                  const Icon(
                Icons.chat,
                color: Colors.white,
              ),

              label:
                  const Text(
                'SEND DETAILS ON WHATSAPP',

                style:
                    TextStyle(
                  color:
                      Colors.white,

                  fontSize:
                      14,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xff25D366,
                ),

                elevation: 0,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    28,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}