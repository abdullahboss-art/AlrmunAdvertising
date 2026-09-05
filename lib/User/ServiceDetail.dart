import 'package:flutter/material.dart';
import 'package:adverting_app/User/GetQuote.dart';
import 'package:adverting_app/User/HomeData.dart';

class ServiceDetail extends StatelessWidget {
  final Map<String, String> service;

  const ServiceDetail({
    super.key,
    required this.service,
  });

  // ============================================================
  // COLORS
  // ============================================================

  static const Color background = Color(0xFF07131B);
  static const Color cardColor = Color(0xFF171717);
  static const Color accent = Color(0xFF2FD6F0);

  // ============================================================
  // CLEAN TITLE
  // ============================================================

  String _cleanTitle(String title) {
    return title
        .replaceAll('\n', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .toUpperCase();
  }

  // ============================================================
  // SERVICE DESCRIPTION
  // ============================================================

  
  // ============================================================
  // SERVICE OFFERS
  // ============================================================

  List<String> getOffers(String title) {
    final String cleanTitle = _cleanTitle(title);

    switch (cleanTitle) {
      // ========================================================
      // 1. GRAPHIC & WEB DESIGN
      // ========================================================

      case "GRAPHIC & WEB DESIGN":
        return [
          "Logo Design",
          "Brand Identity",
          "Business Card Design",
          "Brochure Design",
          "Flyer Design",
          "Social Media Design",
          "Packaging Design",
          "Website Design",
          "UI/UX Design",
          "Banner Design",
          "Poster Design",
          "Corporate Design",
        ];

      // ========================================================
      // 2. ANIMATION & MEDIA PRODUCTION
      // ========================================================

      case "ANIMATION & MEDIA PRODUCTION":
        return [
          "2D Animation",
          "3D Animation",
          "Motion Graphics",
          "Video Editing",
          "Explainer Videos",
          "Product Advertisement",
          "YouTube Video Editing",
          "Reels & Short Videos",
          "Corporate Videos",
          "Promotional Videos",
          "Intro & Outro Videos",
          "Visual Effects",
        ];

      // ========================================================
      // 3. 3D SIGN SOLUTIONS & FABRICATION
      // ========================================================

      case "3D SIGN SOLUTIONS & FABRICATION":
        return [
          "3D Letter Signs",
          "3D Channel Letters",
          "Acrylic Signs",
          "LED Sign Boards",
          "Stainless Steel Signs",
          "Metal Fabrication",
          "Shop Front Signs",
          "Indoor Signage",
          "Outdoor Signage",
          "Backlit Signs",
          "Neon Signage",
          "Custom 3D Signs",
        ];

      // ========================================================
      // 4. DIGITAL & OFFSET PRINTING
      // ========================================================

      case "DIGITAL & OFFSET PRINTING":
        return [
          "Business Cards",
          "Brochures",
          "Flyers",
          "Posters",
          "Catalog Printing",
          "Sticker Printing",
          "Packaging Printing",
          "Offset Printing",
          "Marketing Materials",
          "Letterhead Printing",
          "Envelope Printing",
          "Invitation Cards",
        ];

      // ========================================================
      // 5. LARGE FORMAT PRINTING
      // ========================================================

      case "LARGE FORMAT PRINTING":
        return [
          "Flex Printing",
          "Vinyl Printing",
          "One Way Vision",
          "Billboard Printing",
          "Building Wraps",
          "Vehicle Branding",
          "Backlit Printing",
          "Wall Graphics",
          "Large Promotional Prints",
          "Window Graphics",
          "Outdoor Banners",
          "Event Backdrops",
        ];

      // ========================================================
      // 6. SIGNAGE PRODUCTION & INSTALLATION
      // ========================================================

      case "SIGNAGE PRODUCTION & INSTALLATION":
        return [
          "Sign Board Production",
          "Shop Signage",
          "Indoor Signage",
          "Outdoor Signage",
          "LED Signage",
          "Acrylic Signage",
          "Directional Signs",
          "Wayfinding Signs",
          "Installation Services",
          "Maintenance & Repair",
          "Corporate Signage",
          "Custom Signage",
        ];

      // ========================================================
      // 7. PROMOTIONAL GIFTS PRINTING
      // ========================================================

      case "PROMOTIONAL GIFTS PRINTING":
        return [
          "Custom Mugs",
          "T-Shirts Printing",
          "Caps & Hats",
          "Keychains",
          "Pens",
          "Tote Bags",
          "Corporate Gifts",
          "Customized Products",
          "Branded Promotional Items",
          "Key Rings",
          "Diaries & Notebooks",
          "Promotional Merchandise",
        ];

      // ========================================================
      // 8. EVENTS & EXHIBITION STAND DESIGN
      // ========================================================

      case "EVENTS & EXHIBITION STAND DESIGN":
        return [
          "Exhibition Stand Design",
          "3D Stand Visualization",
          "Booth Design",
          "Backdrop Design",
          "Display Counters",
          "Promotional Displays",
          "Event Branding",
          "Stand Fabrication",
          "Stand Installation",
          "Stage Branding",
          "Reception Counters",
          "Complete Event Setup",
        ];

      // ========================================================
      // DEFAULT
      // ========================================================

      default:
        return [
          "Custom Design Solutions",
          "Professional Consultation",
          "Customized Services",
        ];
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final String title = service['title'] ?? 'Service';

    final String cleanTitle = _cleanTitle(title);

    final String image = service['image'] ?? '';

    final String subtitle = service['subtitle'] ?? '';

    // final String description = getDescription(title);

    final List<String> offers = getOffers(title);

    return Scaffold(
      backgroundColor: background,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        scrolledUnderElevation: 0,

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

        title: Text(
          cleanTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ====================================================
            // SERVICE IMAGE
            // ====================================================

            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),

              child: image.isNotEmpty
                  ? Image.asset(
                      image,

                      width: double.infinity,
                      height: 260,

                      fit: BoxFit.cover,

                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return _imagePlaceholder();
                      },
                    )
                  : _imagePlaceholder(),
            ),

            const SizedBox(height: 25),

            // ====================================================
            // CONTENT
            // ====================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // =================================================
                  // TITLE
                  // =================================================

                  Text(
                    cleanTitle,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 9),

                  // =================================================
                  // SUBTITLE
                  // =================================================

                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,

                      style: const TextStyle(
                        color: accent,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                  const SizedBox(height: 15),

                  // =================================================
                  // DESCRIPTION
                  // =================================================

                  // Text(
                  //   description,

                  //   style: const TextStyle(
                  //     color: Colors.white70,
                  //     fontSize: 15,
                  //     height: 1.7,
                  //   ),
                  // ),

                  const SizedBox(height: 30),

                  // =================================================
                  // WHAT WE OFFER
                  // =================================================

                  const Text(
                    "What We Offer",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Text(
                    "Here are the services and products you can get from us.",

                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // =================================================
                  // OFFER CARD
                  // =================================================

                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: cardColor,

                      borderRadius: BorderRadius.circular(18),

                      border: Border.all(
                        color: Colors.white.withOpacity(0.06),
                      ),
                    ),

                    child: Column(
                      children: List.generate(
                        offers.length,
                        (index) {
                          final String item = offers[index];

                          final bool isLast =
                              index == offers.length - 1;

                          return Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),

                            decoration: BoxDecoration(
                              border: isLast
                                  ? null
                                  : Border(
                                      bottom: BorderSide(
                                        color: Colors.white
                                            .withOpacity(0.05),
                                      ),
                                    ),
                            ),

                            child: Row(
                              children: [
                                // ==================================
                                // CHECK ICON
                                // ==================================

                                Container(
                                  width: 30,
                                  height: 30,

                                  decoration: BoxDecoration(
                                    color:
                                        accent.withOpacity(0.10),

                                    borderRadius:
                                        BorderRadius.circular(9),
                                  ),

                                  child: const Icon(
                                    Icons.check_rounded,
                                    color: accent,
                                    size: 18,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // ==================================
                                // OFFER NAME
                                // ==================================

                                Expanded(
                                  child: Text(
                                    item,

                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                                // ==================================
                                // ARROW
                                // ==================================

                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white24,
                                  size: 13,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // =================================================
                  // GET QUOTE BUTTON
                  // =================================================

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.black,
                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GetAQuotePage(
                              serviceTitle: cleanTitle,
                            ),
                          ),
                        );
                      },

                      child: const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [
                          Icon(
                            Icons.request_quote_outlined,
                            size: 19,
                          ),

                          SizedBox(width: 8),

                          Text(
                            "Get a Quote",

                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // IMAGE PLACEHOLDER
  // ============================================================

  Widget _imagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 260,

      color: cardColor,

      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: Colors.white38,
          size: 60,
        ),
      ),
    );
  }
}