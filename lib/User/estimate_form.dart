import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'estimate_data.dart';

// =============================================================
// ESTIMATE HEADER
// =============================================================

class EstimateHeader extends StatelessWidget {
  const EstimateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 28,
                height: 1,
                color: EstimateColors.accent.withOpacity(0.7),
              ),
              const SizedBox(width: 9),
              const SizedBox(width: 9),
            ],
          ),
          const SizedBox(height: 9),
          const SizedBox(height: 7),
        ],
      ),
    );
  }
}

// =============================================================
// REQUIREMENTS CARD
// =============================================================

class RequirementsCard extends StatelessWidget {
  final String? selectedCategory;
  final String selectedUnit;

  // Installation sirf un services ke liye hoga jahan zaroorat ho
  final bool withInstallation;

  final TextEditingController quantityController;
  final TextEditingController widthController;
  final TextEditingController heightController;

  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<String> onUnitChanged;
  final ValueChanged<bool> onInstallationChanged;

  final VoidCallback onCalculate;

  final ScrollController scrollController;
  final GlobalKey quantityKey;

  const RequirementsCard({
    super.key,
    required this.selectedCategory,
    required this.selectedUnit,
    required this.withInstallation,
    required this.quantityController,
    required this.widthController,
    required this.heightController,
    required this.onCategoryChanged,
    required this.onUnitChanged,
    required this.onInstallationChanged,
    required this.onCalculate,
    required this.scrollController,
    required this.quantityKey,
  });

  // ===========================================================
  // SERVICES JIN KO INSTALLATION KI ZAROORAT NAHI
  // ===========================================================

  bool get isInstallationRequiredService {
    final category = selectedCategory?.toLowerCase() ?? '';

    const nonInstallationServices = [
      'business cards',
      'business card',
      'flyers',
      'flyer',
      'brochures',
      'brochure',
      'posters',
      'poster',
      'stationery',
      'letterheads',
      'letterhead',
      'invitation cards',
      'invitation card',
      'stickers',
      'sticker',
      'labels',
      'label',
    ];

    return !nonInstallationServices.contains(category);
  }

  @override
  Widget build(BuildContext context) {
    final showInstallation =
        selectedCategory != null &&
        isInstallationRequiredService;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: EstimateColors.cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: EstimateColors.borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =====================================================
          // HEADER
          // =====================================================

          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: EstimateColors.accent.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.tune_rounded,
                  color: EstimateColors.accent,
                  size: 19,
                ),
              ),
              const SizedBox(width: 11),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Requirements',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Select your product and enter the details.',
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // =====================================================
          // CATEGORY TITLE
          // =====================================================

          const Text(
            'What do you want to print?',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 9),

          // =====================================================
          // CATEGORY GRID
          // =====================================================

          CategoryGrid(
            selectedCategory: selectedCategory,
            onSelected: onCategoryChanged,
            scrollController: scrollController,
            quantityKey: quantityKey,
          ),

          const SizedBox(height: 20),

          // =====================================================
          // QUANTITY
          // =====================================================

          KeyedSubtree(
            key: quantityKey,
            child: EstimateTextField(
              label: 'Quantity',
              controller: quantityController,
              hint: 'Enter quantity',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter quantity';
                }

                final number = double.tryParse(value);

                if (number == null) {
                  return 'Enter a valid quantity';
                }

                if (number <= 0) {
                  return 'Quantity must be greater than 0';
                }

                return null;
              },
            ),
          ),

          const SizedBox(height: 14),

          // =====================================================
          // WIDTH + HEIGHT
          // =====================================================

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: EstimateTextField(
                  label: 'Width',
                  controller: widthController,
                  hint: 'e.g. 10',
                  keyboardType:
                      const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter width';
                    }

                    final number = double.tryParse(value);

                    if (number == null) {
                      return 'Invalid width';
                    }

                    if (number <= 0) {
                      return 'Must be greater than 0';
                    }

                    return null;
                  },
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: EstimateTextField(
                  label: 'Height',
                  controller: heightController,
                  hint: 'e.g. 5',
                  keyboardType:
                      const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter height';
                    }

                    final number = double.tryParse(value);

                    if (number == null) {
                      return 'Invalid height';
                    }

                    if (number <= 0) {
                      return 'Must be greater than 0';
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // =====================================================
          // MEASUREMENT UNIT
          // =====================================================

          MeasurementDropdown(
            selectedUnit: selectedUnit,
            onChanged: onUnitChanged,
          ),

          // =====================================================
          // INSTALLATION
          // =====================================================

          if (showInstallation) ...[
            const SizedBox(height: 14),

            InstallationSelector(
              withInstallation: withInstallation,
              onChanged: onInstallationChanged,
            ),
          ],

          const SizedBox(height: 20),

          // =====================================================
          // CALCULATE BUTTON
          // =====================================================

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onCalculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: EstimateColors.accent,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calculate_outlined,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'CALCULATE ESTIMATE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// CATEGORY GRID
// =============================================================

class CategoryGrid extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String> onSelected;
  final ScrollController scrollController;
  final GlobalKey quantityKey;

  const CategoryGrid({
    super.key,
    required this.selectedCategory,
    required this.onSelected,
    required this.scrollController,
    required this.quantityKey,
  });

  // ===========================================================
  // CATEGORY SELECT + SCROLL
  // ===========================================================

  void _selectCategory(
    BuildContext context,
    String category,
  ) {
    onSelected(category);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          if (!context.mounted) return;

          final quantityContext =
              quantityKey.currentContext;

          if (quantityContext != null) {
            Scrollable.ensureVisible(
              quantityContext,
              duration: const Duration(
                milliseconds: 700,
              ),
              curve: Curves.easeInOutCubic,
              alignment: 0.08,
            );
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns =
            constraints.maxWidth < 350 ? 2 : 3;

        return GridView.builder(
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(),
          itemCount:
              advertisingCategories.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio:
                columns == 2 ? 1.65 : 1.35,
          ),
          itemBuilder: (context, index) {
            final item =
                advertisingCategories[index];

            final bool isSelected =
                selectedCategory ==
                    item['title'];

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                _selectCategory(
                  context,
                  item['title'],
                );
              },
              child: AnimatedContainer(
                duration:
                    const Duration(milliseconds: 180),
                padding:
                    const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? EstimateColors.accent
                          .withOpacity(0.10)
                      : EstimateColors.fieldColor,
                  borderRadius:
                      BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? EstimateColors.accent
                        : EstimateColors.borderColor,
                    width:
                        isSelected ? 1.3 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration:
                              BoxDecoration(
                            color: isSelected
                                ? EstimateColors
                                    .accent
                                    .withOpacity(
                                        0.14)
                                : Colors.white
                                    .withOpacity(
                                        0.04),
                            borderRadius:
                                BorderRadius.circular(
                                    8),
                          ),
                          child: Icon(
                            item['icon'],
                            size: 15,
                            color: isSelected
                                ? EstimateColors
                                    .accent
                                : Colors.white60,
                          ),
                        ),

                        if (isSelected) ...[
                          const Spacer(),
                          const Icon(
                            Icons.check_circle,
                            color:
                                EstimateColors.accent,
                            size: 15,
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 7),

                    Text(
                      item['title'],
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9.5,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      item['subtitle'],
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 6.8,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// =============================================================
// TEXT FIELD
// =============================================================

class EstimateTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const EstimateTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    required this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    // Width aur Height ke liye decimal allow
    final bool allowDecimal =
        label == 'Width' || label == 'Height';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 6),

        TextFormField(
          controller: controller,
          keyboardType: allowDecimal
              ? const TextInputType.numberWithOptions(
                  decimal: true,
                )
              : TextInputType.number,

          // =====================================================
          // ONLY NUMBERS ALLOWED
          // =====================================================

     inputFormatters: [
  if (allowDecimal)
    FilteringTextInputFormatter.allow(
      RegExp(r'^\d*\.?\d*'),
    )
  else
    FilteringTextInputFormatter.digitsOnly,
],

          validator: validator,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
          ),

          decoration: InputDecoration(
            hintText: hint,

            hintStyle: const TextStyle(
              color: Colors.white24,
              fontSize: 10.5,
            ),

            filled: true,

            fillColor:
                EstimateColors.fieldColor,

            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 13,
            ),

            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(11),
              borderSide: const BorderSide(
                color:
                    EstimateColors.borderColor,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(11),
              borderSide: const BorderSide(
                color:
                    EstimateColors.borderColor,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(11),
              borderSide: const BorderSide(
                color:
                    EstimateColors.accent,
                width: 1.2,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: Colors.redAccent,
              ),
            ),

            focusedErrorBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(11),
              borderSide: const BorderSide(
                color: Colors.redAccent,
              ),
            ),

            errorStyle: const TextStyle(
              fontSize: 8.5,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
// =============================================================
// MEASUREMENT DROPDOWN
// =============================================================

class MeasurementDropdown extends StatelessWidget {
  final String selectedUnit;
  final ValueChanged<String> onChanged;

  const MeasurementDropdown({
    super.key,
    required this.selectedUnit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Measurement Unit',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 6),

        DropdownButtonFormField<String>(
          value: selectedUnit,
          dropdownColor:
              EstimateColors.cardColor,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor:
                EstimateColors.fieldColor,
            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 5,
            ),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(11),
              borderSide: const BorderSide(
                color:
                    EstimateColors.borderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(11),
              borderSide: const BorderSide(
                color:
                    EstimateColors.borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(11),
              borderSide: const BorderSide(
                color:
                    EstimateColors.accent,
              ),
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white60,
          ),
          items: const [
            DropdownMenuItem(
              value: 'Centimeters (cm)',
              child: Text(
                'Centimeters (cm)',
              ),
            ),
            DropdownMenuItem(
              value: 'Inches (in)',
              child: Text(
                'Inches (in)',
              ),
            ),
            DropdownMenuItem(
              value: 'Feet (ft)',
              child: Text(
                'Feet (ft)',
              ),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              onChanged(value);
            }
          },
        ),
      ],
    );
  }
}

// =============================================================
// INSTALLATION SELECTOR
// =============================================================

class InstallationSelector extends StatelessWidget {
  final bool withInstallation;
  final ValueChanged<bool> onChanged;

  const InstallationSelector({
    super.key,
    required this.withInstallation,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Installation',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 7),

        Container(
          height: 46,
          padding:
              const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color:
                EstimateColors.fieldColor,
            borderRadius:
                BorderRadius.circular(12),
            border: Border.all(
              color:
                  EstimateColors.borderColor,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _InstallationOption(
                  selected:
                      !withInstallation,
                  icon: Icons
                      .remove_circle_outline,
                  text:
                      'Without Installation',
                  onTap: () =>
                      onChanged(false),
                ),
              ),

              const SizedBox(width: 4),

              Expanded(
                child: _InstallationOption(
                  selected:
                      withInstallation,
                  icon: Icons
                      .check_circle_outline,
                  text:
                      'With Installation',
                  onTap: () =>
                      onChanged(true),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================
// INSTALLATION OPTION
// =============================================================

class _InstallationOption
    extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _InstallationOption({
    required this.selected,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 180),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? EstimateColors.accent
                  .withOpacity(0.12)
              : Colors.transparent,
          borderRadius:
              BorderRadius.circular(9),
          border: Border.all(
            color: selected
                ? EstimateColors.accent
                    .withOpacity(0.7)
                : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 14,
              color: selected
                  ? EstimateColors.accent
                  : Colors.white30,
            ),

            const SizedBox(width: 6),

            Flexible(
              child: Text(
                text,
                overflow:
                    TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : Colors.white38,
                  fontSize: 9,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}