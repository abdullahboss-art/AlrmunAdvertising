

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:printing/printing.dart';

import 'quote_helpers.dart';
import 'quote_pdf.dart';
import 'quote_widgets.dart';

class GetAQuotePage extends StatefulWidget {
  final String serviceTitle;

  const GetAQuotePage({
    super.key,
    required this.serviceTitle,
  });

  @override
  State<GetAQuotePage> createState() =>
      _GetAQuotePageState();
}

class _GetAQuotePageState
    extends State<GetAQuotePage> {
  static const String whatsappNumber =
      '923152635232';

  final _formKey = GlobalKey<FormState>();

  // IMPORTANT:
  // Ye ab actual Quantity hai.
  final _quantityController =
      TextEditingController();

  final _widthController =
      TextEditingController();

  final _heightController =
      TextEditingController();

  static const List<String> measurementUnits = [
    'Centimeters (cm)',
    'Inches (in)',
    'Feet (ft)',
  ];

  String? selectedUnit = measurementUnits.first;

  bool withInstallation = true;
  bool submitted = false;
  bool isGenerating = false;

  static const double
      pricePerSqFtWithoutInstallation = 25.0;

  static const double
      pricePerSqFtWithInstallation = 35.0;

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

  double toFeet(double value) {
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

  double get widthInFeet =>
      toFeet(width);

  double get heightInFeet =>
      toFeet(height);

  double get squareFeet =>
      widthInFeet * heightInFeet;

  double get pricePerSqFt =>
      withInstallation
          ? pricePerSqFtWithInstallation
          : pricePerSqFtWithoutInstallation;

  double get totalPrice =>
      squareFeet * pricePerSqFt;

  @override
  void dispose() {
    _quantityController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void submitRequest() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      submitted = true;
    });

    FocusScope.of(context).unfocus();
  }

  String get whatsappMessage => '''
Hello, I would like to request a quote.

Quantity: ${_quantityController.text.trim()}

Required Service: ${widget.serviceTitle}

Width: ${_widthController.text.trim()}

Height: ${_heightController.text.trim()}

Measurement Unit: ${selectedUnit ?? ''}

Installation: ${withInstallation ? 'With Installation' : 'Without Installation'}

Area: ${squareFeet.toStringAsFixed(2)} sq ft

Rate: AED ${pricePerSqFt.toStringAsFixed(2)} / sq ft

Total Price: AED ${totalPrice.toStringAsFixed(2)}

Request ID: ${QuoteHelpers.requestId()}

Thank you.
''';

  Future<void> openWhatsApp() async {
    final encoded =
        Uri.encodeComponent(
      whatsappMessage,
    );

    final uri = Uri.parse(
      'https://wa.me/$whatsappNumber?text=$encoded',
    );

    try {
      final launched =
          await launchUrl(
        uri,
        mode:
            LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content:
                Text('Could not open WhatsApp.'),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text('Could not open WhatsApp.'),
        ),
      );
    }
  }

  Future<void> sharePdf() async {
    setState(() {
      isGenerating = true;
    });

    try {
      final pdfBytes =
          await QuotePdf.generate(
        companyName: 'YOUR COMPANY',
        requestId:
            QuoteHelpers.requestId(),
        date:
            QuoteHelpers.formattedDate(),
        quantity:
            _quantityController.text.trim(),
        service:
            widget.serviceTitle,
        width:
            _widthController.text.trim(),
        height:
            _heightController.text.trim(),
        unit:
            selectedUnit ?? '',
        installation:
            withInstallation
                ? 'With Installation'
                : 'Without Installation',
        area: squareFeet,
        rate: pricePerSqFt,
        total: totalPrice,
      );

      await Printing.sharePdf(
        bytes: pdfBytes,
        filename:
            'Quotation_Request_${QuoteHelpers.requestId()}.pdf',
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
              Text('Could not generate PDF: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isGenerating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xff0D0D0D),

      appBar: AppBar(
        backgroundColor:
            Colors.transparent,
        elevation: 0,
        iconTheme:
            const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Get a Quote',
          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.fromLTRB(
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

                if (submitted)
                  ...[
                    const SizedBox(
                      height: 18,
                    ),
                    buildResult(),
                  ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return QuoteWidgets.sectionCard(
      title: 'Your Requirements',
      subtitle:
          'Select your service and enter the required details.',

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          selectedService(),

          QuoteWidgets.formField(
            label: 'Quantity',
            controller:
                _quantityController,
            icon:
                Icons.production_quantity_limits,
            hint:
                'Enter quantity',
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

          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Expanded(
                child:
                    QuoteWidgets.formField(
                  label: 'Width',
                  controller:
                      _widthController,
                  icon:
                      Icons.straighten_outlined,
                  hint: 'e.g. 10',
                  keyboardType:
                      TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Enter width';
                    }

                    return null;
                  },
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child:
                    QuoteWidgets.formField(
                  label: 'Height',
                  controller:
                      _heightController,
                  icon:
                      Icons.height_outlined,
                  hint: 'e.g. 5',
                  keyboardType:
                      TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Enter height';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),

          QuoteWidgets.dropdownField(
            label: 'Measurement Unit',
            value: selectedUnit,
            options:
                measurementUnits,
            icon:
                Icons.square_foot_outlined,
            hint:
                'Select measurement unit',
            onChanged: (value) {
              setState(() {
                selectedUnit =
                    value;
              });
            },
            validator: (value) {
              if (value == null ||
                  value.isEmpty) {
                return 'Please select a measurement unit';
              }

              return null;
            },
          ),

          QuoteWidgets.toggleField(
            label: 'Installation',
            value:
                withInstallation,
            trueLabel:
                'With Installation',
            falseLabel:
                'Without Installation',
            onChanged: (value) {
              setState(() {
                withInstallation =
                    value;
              });
            },
          ),

          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed:
                  submitRequest,
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    QuoteHelpers.accent,
                foregroundColor:
                    const Color(
                  0xff0D0D0D,
                ),
                elevation: 0,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
              ),
              child:
                  const Text(
                'SUBMIT REQUEST',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                      FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectedService() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(14),
      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),
      decoration:
          BoxDecoration(
        color:
            QuoteHelpers.fieldBg,
        borderRadius:
            BorderRadius.circular(12),
        border:
            Border.all(
          color:
              QuoteHelpers.accent
                  .withOpacity(0.35),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.design_services_outlined,
            color:
                QuoteHelpers.accent,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selected Service',
                  style: TextStyle(
                    color:
                        Colors.white54,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(
                  height: 3,
                ),

                Text(
                  widget.serviceTitle,
                  style:
                      const TextStyle(
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
        ],
      ),
    );
  }

  Widget buildResult() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(18),
      decoration:
          BoxDecoration(
        color:
            QuoteHelpers.cardBg,
        borderRadius:
            BorderRadius.circular(18),
        border:
            Border.all(
          color:
              QuoteHelpers.accent
                  .withOpacity(0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'YOUR REQUEST',
            style: TextStyle(
              color:
                  Colors.white38,
              fontSize: 11.5,
              fontWeight:
                  FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            '✓ Request Submitted',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          QuoteWidgets.summaryRow(
            'Quantity',
            _quantityController
                .text
                .trim(),
          ),

          QuoteWidgets.summaryRow(
            'Service',
            widget.serviceTitle,
          ),

          QuoteWidgets.summaryRow(
            'Width',
            _widthController
                .text
                .trim(),
          ),

          QuoteWidgets.summaryRow(
            'Height',
            _heightController
                .text
                .trim(),
          ),

          QuoteWidgets.summaryRow(
            'Unit',
            selectedUnit ?? '',
          ),

          QuoteWidgets.summaryRow(
            'Installation',
            withInstallation
                ? 'With Installation'
                : 'Without Installation',
          ),

          const Divider(
            color:
                Colors.white12,
          ),

          QuoteWidgets.summaryRow(
            'Area',
            '${squareFeet.toStringAsFixed(2)} sq ft',
          ),

          QuoteWidgets.summaryRow(
            'Rate',
            'AED ${pricePerSqFt.toStringAsFixed(2)} / sq ft',
          ),

          const SizedBox(height: 8),

          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.all(16),
            decoration:
                BoxDecoration(
              color:
                  QuoteHelpers.accent
                      .withOpacity(0.12),
              borderRadius:
                  BorderRadius.circular(14),
              border:
                  Border.all(
                color:
                    QuoteHelpers.accent
                        .withOpacity(0.45),
              ),
            ),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
              children: [
                const Text(
                  'TOTAL PRICE',
                  style: TextStyle(
                    color:
                        Colors.white70,
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),

                Text(
                  'AED ${totalPrice.toStringAsFixed(2)}',
                  style:
                      const TextStyle(
                    color:
                        QuoteHelpers
                            .accent,
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

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
                color:
                    Colors.white,
              ),
              label:
                  const Text(
                'SEND DETAILS ON WHATSAPP',
                style:
                    TextStyle(
                  color:
                      Colors.white,
                  fontSize: 14,
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

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            height: 52,
            child:
                OutlinedButton.icon(
              onPressed:
                  isGenerating
                      ? null
                      : sharePdf,
              icon: isGenerating
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                        color:
                            QuoteHelpers
                                .accent,
                      ),
                    )
                  : const Icon(
                      Icons.share,
                      color:
                          QuoteHelpers
                              .accent,
                    ),
              label: Text(
                isGenerating
                    ? 'GENERATING PDF...'
                    : 'SHARE PDF',
                style:
                    const TextStyle(
                  color:
                      Colors.white,
                  fontSize: 14,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              style:
                  OutlinedButton.styleFrom(
                side:
                    const BorderSide(
                  color:
                      QuoteHelpers
                          .accent,
                ),
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