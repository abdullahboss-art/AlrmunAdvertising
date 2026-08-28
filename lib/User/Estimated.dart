import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvertisingEstimatePage extends StatefulWidget {
  const AdvertisingEstimatePage({
    super.key,
  });

  @override
  State<AdvertisingEstimatePage> createState() =>
      _AdvertisingEstimatePageState();
}

class _AdvertisingEstimatePageState
    extends State<AdvertisingEstimatePage> {
  static const Color background = Color(0xFF0B1016);
  static const Color cardColor = Color(0xFF131A21);
  static const Color fieldColor = Color(0xFF171F27);
  static const Color borderColor = Color(0xFF29343E);
  static const Color accent = Color(0xFF36B7C2);

  static const String whatsappNumber = '923152635232';

  final _formKey = GlobalKey<FormState>();
  final _resultKey = GlobalKey();
  final _scrollController = ScrollController();

  final TextEditingController _quantityController =
      TextEditingController();

  final TextEditingController _widthController =
      TextEditingController();

  final TextEditingController _heightController =
      TextEditingController();

  String? selectedCategory;

  String selectedUnit = 'Feet (ft)';

  bool withInstallation = false;

  bool submitted = false;

  // ------------------------------------------------------------
  // Categories
  // ------------------------------------------------------------

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Banner',
      'subtitle': 'Indoor & outdoor banners',
      'icon': Icons.flag_outlined,
      'rate': 25.0,
    },
    {
      'title': 'Billboard',
      'subtitle': 'Large format roadside media',
      'icon': Icons.panorama_outlined,
      'rate': 45.0,
    },
    {
      'title': 'Flex Printing',
      'subtitle': 'Durable flex media printing',
      'icon': Icons.print_outlined,
      'rate': 20.0,
    },
    {
      'title': 'Vinyl Printing',
      'subtitle': 'Premium vinyl graphics',
      'icon': Icons.layers_outlined,
      'rate': 30.0,
    },
    {
      'title': 'Sticker',
      'subtitle': 'Cut & printed stickers',
      'icon': Icons.sell_outlined,
      'rate': 18.0,
    },
    {
      'title': 'Sign Board',
      'subtitle': 'Shop & building sign boards',
      'icon': Icons.signpost_outlined,
      'rate': 55.0,
    },
    {
      'title': '3D Letters',
      'subtitle': 'Fabricated dimensional letters',
      'icon': Icons.view_in_ar_outlined,
      'rate': 85.0,
    },
    {
      'title': 'Business Cards',
      'subtitle': 'Corporate print cards',
      'icon': Icons.credit_card_outlined,
      'rate': 15.0,
    },
    {
      'title': 'Flyers',
      'subtitle': 'Professional flyer printing',
      'icon': Icons.description_outlined,
      'rate': 12.0,
    },
  ];

  // ------------------------------------------------------------
  // Calculations
  // ------------------------------------------------------------

  double get quantity {
    return double.tryParse(
          _quantityController.text.trim(),
        ) ??
        0;
  }

  double get width {
    return double.tryParse(
          _widthController.text.trim(),
        ) ??
        0;
  }

  double get height {
    return double.tryParse(
          _heightController.text.trim(),
        ) ??
        0;
  }

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

  double get widthInFeet {
    return convertToFeet(width);
  }

  double get heightInFeet {
    return convertToFeet(height);
  }

  double get area {
    return widthInFeet * heightInFeet;
  }

  double get selectedRate {
    if (selectedCategory == null) {
      return 0;
    }

    final category = categories.firstWhere(
      (item) => item['title'] == selectedCategory,
    );

    return category['rate'] as double;
  }

  double get installationCost {
    if (!withInstallation) {
      return 0;
    }

    return area * quantity * 10;
  }

  double get printingCost {
    return area * quantity * selectedRate;
  }

  double get totalPrice {
    return printingCost + installationCost;
  }

  // ------------------------------------------------------------
  // Submit
  // ------------------------------------------------------------

  void calculateEstimate() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      submitted = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final context = _resultKey.currentContext;

      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(
            milliseconds: 700,
          ),
          curve: Curves.easeInOutCubic,
          alignment: 0.04,
        );
      }
    });
  }

  // ------------------------------------------------------------
  // WhatsApp
  // ------------------------------------------------------------

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

  Future<void> openWhatsApp() async {
    final message = Uri.encodeComponent(
      whatsappMessage,
    );

    final uri = Uri.parse(
      'https://wa.me/$whatsappNumber?text=$message',
    );

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched && mounted) {
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

  // ------------------------------------------------------------
  // Dispose
  // ------------------------------------------------------------

  @override
  void dispose() {
    _quantityController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------
  // Main UI
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
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
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,

          padding: const EdgeInsets.fromLTRB(
            18,
            8,
            18,
            40,
          ),

          child: Form(
            key: _formKey,

            child: Column(
              children: [
                buildHeader(),

                const SizedBox(height: 22),

                buildRequirementsCard(),

                if (submitted) ...[
                  const SizedBox(height: 18),

                  buildEstimateCard(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Header
  // ------------------------------------------------------------

  Widget buildHeader() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 35,
              height: 1,
              color: accent,
            ),

            const SizedBox(width: 10),

            const Text(
              'INSTANT ESTIMATION',
              style: TextStyle(
                color: accent,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(width: 10),

            Container(
              width: 35,
              height: 1,
              color: accent,
            ),
          ],
        ),

        const SizedBox(height: 7),

        const Text(
          'Get Your Instant Estimate',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          'Enter your printing requirements and get an estimated cost instantly.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white38,
            fontSize: 10.5,
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Requirements Card
  // ------------------------------------------------------------

  Widget buildRequirementsCard() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),

        border: Border.all(
          color: borderColor,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Requirements',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 3),

          const Text(
            'Select your product and enter the required details.',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 9.5,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'What do you want to print?',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 9),

          buildCategoryGrid(),

          const SizedBox(height: 18),

          buildTextField(
            label: 'Quantity',
            controller: _quantityController,
            hint: '1',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty) {
                return 'Please enter quantity';
              }

              if (double.tryParse(value) == null) {
                return 'Enter a valid quantity';
              }

              if (double.parse(value) <= 0) {
                return 'Quantity must be greater than 0';
              }

              return null;
            },
          ),

          const SizedBox(height: 13),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: buildTextField(
                  label: 'Width',
                  controller: _widthController,
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

                    if (double.tryParse(value) == null) {
                      return 'Invalid width';
                    }

                    return null;
                  },
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: buildTextField(
                  label: 'Height',
                  controller: _heightController,
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

                    if (double.tryParse(value) == null) {
                      return 'Invalid height';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          buildDropdown(),

          const SizedBox(height: 13),

          buildInstallation(),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 52,

            child: ElevatedButton(
              onPressed: calculateEstimate,

              style: ElevatedButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: const Color(0xFF081014),
                elevation: 0,

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(28),
                ),
              ),

              child: const Text(
                'CALCULATE ESTIMATE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Category Grid
  // ------------------------------------------------------------

  Widget buildCategoryGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      itemCount: categories.length,

      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 7,
        mainAxisSpacing: 7,
        childAspectRatio: 1.75,
      ),

      itemBuilder: (context, index) {
        final item = categories[index];

        final isSelected =
            selectedCategory == item['title'];

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedCategory = item['title'];
            });
          },

          child: AnimatedContainer(
            duration:
                const Duration(milliseconds: 180),

            padding: const EdgeInsets.all(9),

            decoration: BoxDecoration(
              color: isSelected
                  ? accent.withOpacity(0.10)
                  : fieldColor,

              borderRadius:
                  BorderRadius.circular(6),

              border: Border.all(
                color: isSelected
                    ? accent
                    : borderColor,
              ),
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [
                Icon(
                  item['icon'],
                  size: 15,
                  color: isSelected
                      ? accent
                      : Colors.white70,
                ),

                const SizedBox(height: 3),

                Text(
                  item['title'],
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.white,
                    fontSize: 9,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  item['subtitle'],
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 6.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // Text Field
  // ------------------------------------------------------------

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required TextInputType keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 5),

        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),

          decoration: InputDecoration(
            hintText: hint,

            hintStyle: const TextStyle(
              color: Colors.white24,
              fontSize: 10,
            ),

            filled: true,
            fillColor: fieldColor,

            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),

            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(6),
              borderSide:
                  const BorderSide(
                color: borderColor,
              ),
            ),

            enabledBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(6),
              borderSide:
                  const BorderSide(
                color: borderColor,
              ),
            ),

            focusedBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(6),
              borderSide:
                  const BorderSide(
                color: accent,
              ),
            ),

            errorBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(6),
              borderSide:
                  const BorderSide(
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Dropdown
  // ------------------------------------------------------------

  Widget buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Measurement Unit',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 5),

        DropdownButtonFormField<String>(
          value: selectedUnit,

          dropdownColor: cardColor,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 10.5,
          ),

          decoration: InputDecoration(
            filled: true,
            fillColor: fieldColor,

            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 5,
            ),

            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(6),
              borderSide:
                  const BorderSide(
                color: borderColor,
              ),
            ),

            enabledBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(6),
              borderSide:
                  const BorderSide(
                color: borderColor,
              ),
            ),
          ),

          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white70,
          ),

          items: const [
            DropdownMenuItem(
              value: 'Centimeters (cm)',
              child: Text('Centimeters (cm)'),
            ),
            DropdownMenuItem(
              value: 'Inches (in)',
              child: Text('Inches (in)'),
            ),
            DropdownMenuItem(
              value: 'Feet (ft)',
              child: Text('Feet (ft)'),
            ),
          ],

          onChanged: (value) {
            if (value == null) return;

            setState(() {
              selectedUnit = value;
            });
          },
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Installation
  // ------------------------------------------------------------

  Widget buildInstallation() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        const Text(
          'Installation',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 9.5,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 6),

        Container(
          height: 40,

          decoration: BoxDecoration(
            color: fieldColor,
            borderRadius:
                BorderRadius.circular(6),
            border:
                Border.all(
              color: borderColor,
            ),
          ),

          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      withInstallation = false;
                    });
                  },

                  child: Container(
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: !withInstallation
                          ? accent.withOpacity(0.08)
                          : Colors.transparent,

                      borderRadius:
                          BorderRadius.circular(5),

                      border: Border.all(
                        color: !withInstallation
                            ? accent
                            : Colors.transparent,
                      ),
                    ),

                    child: Text(
                      'Without Installation',
                      style: TextStyle(
                        color: !withInstallation
                            ? Colors.white
                            : Colors.white38,
                        fontSize: 9,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      withInstallation = true;
                    });
                  },

                  child: Container(
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: withInstallation
                          ? accent.withOpacity(0.08)
                          : Colors.transparent,

                      borderRadius:
                          BorderRadius.circular(5),

                      border: Border.all(
                        color: withInstallation
                            ? accent
                            : Colors.transparent,
                      ),
                    ),

                    child: Text(
                      'With Installation',
                      style: TextStyle(
                        color: withInstallation
                            ? Colors.white
                            : Colors.white38,
                        fontSize: 9,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Estimate Result Card
  // ------------------------------------------------------------

  Widget buildEstimateCard() {
    return Container(
      key: _resultKey,

      width: double.infinity,

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius:
            BorderRadius.circular(8),

        border: Border.all(
          color: accent.withOpacity(0.35),
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                width: 7,
                height: 7,

                decoration:
                    const BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 7),

              const Text(
                'YOUR ESTIMATE',
                style: TextStyle(
                  color: accent,
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          const Text(
            'Estimated Cost',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 13),

          // Total
          Container(
            width: double.infinity,

            padding:
                const EdgeInsets.symmetric(
              vertical: 17,
            ),

            decoration: BoxDecoration(
              color: fieldColor,

              borderRadius:
                  BorderRadius.circular(7),

              border: Border.all(
                color: borderColor,
              ),
            ),

            child: Column(
              children: [
                const Text(
                  'ESTIMATED TOTAL',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 7.5,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  'AED ${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: accent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          buildSummaryRow(
            'Printing Type',
            selectedCategory ?? '—',
          ),

          buildSummaryRow(
            'Quantity',
            quantity.toStringAsFixed(0),
          ),

          buildSummaryRow(
            'Size',
            '${_widthController.text.trim()} × '
                '${_heightController.text.trim()} $selectedUnit',
          ),

          buildSummaryRow(
            'Total Area',
            '${area.toStringAsFixed(2)} sq ft',
          ),

          buildSummaryRow(
            'Printing Cost',
            'AED ${printingCost.toStringAsFixed(2)}',
          ),

          buildSummaryRow(
            'Installation',
            'AED ${installationCost.toStringAsFixed(2)}',
          ),

          const SizedBox(height: 13),

          const Text(
            'This is an estimated price. Final pricing may depend on material, design and project requirements.',
            style: TextStyle(
              color: Colors.white24,
              fontSize: 7.5,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            height: 46,

            child: ElevatedButton.icon(
              onPressed: openWhatsApp,

              icon: const Icon(
                Icons.chat,
                color: Colors.white,
                size: 17,
              ),

              label: const Text(
                'ORDER NOW ON WHATSAPP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),

              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF2DBBC4),

                elevation: 0,

                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Summary Row
  // ------------------------------------------------------------

  Widget buildSummaryRow(
    String title,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 11),

      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 8.5,
              ),
            ),
          ),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 8.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
    }