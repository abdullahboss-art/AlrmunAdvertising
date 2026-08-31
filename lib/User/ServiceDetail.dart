
import 'package:flutter/material.dart';
import 'package:adverting_app/User/GetQuote.dart';

class ServiceDetail extends StatelessWidget {
  final Map<String, String> service;

  const ServiceDetail({
    super.key,
    required this.service,
    required String serviceName,
  });

  // ============================================================
  // WHAT WE OFFER
  // ============================================================

  List<String> getOffers(String title) {
    switch (title) {
      case "Graphic Design":
        return [
          "Logo Design",
          "Brand Identity",
          "Business Card Design",
          "Brochure Design",
          "Flyer Design",
          "Social Media Design",
          "Packaging Design",
          "Banner Design",
          "UI/UX Design",
        ];

      case "Animation & Media":
        return [
          "2D Animation",
          "3D Animation",
          "Motion Graphics",
          "Video Editing",
          "Explainer Videos",
          "Product Advertisement",
          "YouTube Editing",
          "Reels Editing",
          "Corporate Videos",
        ];

      case "3D Visualization":
        return [
          "Interior Rendering",
          "Exterior Rendering",
          "3D Product Design",
          "Furniture Modeling",
          "Architecture Modeling",
          "Walkthrough Animation",
          "Industrial Design",
          "Landscape Design",
          "3D Floor Plans",
        ];

      case "Digital & Offset":
        return [
          "Business Cards",
          "Brochures",
          "Flyers",
          "Posters",
          "Roll-up Stands",
          "Catalog Printing",
          "Packaging Printing",
          "Offset Printing",
          "Sticker Printing",
        ];

      case "Outdoor Advertising":
        return [
          "Social Media Marketing",
          "Facebook Marketing",
          "Instagram Marketing",
          "Google Ads",
          "Content Marketing",
          "SEO",
          "Brand Promotion",
          "Online Advertising",
          "Marketing Strategy",
        ];

      case "Branding":
        return [
          "Logo Design",
          "Brand Identity",
          "Business Cards",
          "Letterhead Design",
          "Brand Guidelines",
          "Packaging Branding",
          "Social Media Branding",
          "Marketing Materials",
          "Complete Brand Identity",
        ];
      case "Flex Printing":
        return [
          "Logo Design",
          "Brand Identity",
          "Business Cards",
          "Letterhead Design",
          "Brand Guidelines",
          "Packaging Branding",
          "Social Media Branding",
          "Marketing Materials",
          "Complete Brand Identity",
        ];
      case "Sign Boards":
        return [
          "Logo Design",
          "Brand Identity",
          "Business Cards",
          "Letterhead Design",
          "Brand Guidelines",
          "Packaging Branding",
          "Social Media Branding",
          "Marketing Materials",
          "Complete Brand Identity",
        ];
      case "3D Letters":
        return [
          "Logo Design",
          "Brand Identity",
          "Business Cards",
          "Letterhead Design",
          "Brand Guidelines",
          "Packaging Branding",
          "Social Media Branding",
          "Marketing Materials",
          "Complete Brand Identity",
        ];

      case "Business Cards":
        return [
          "Logo Design",
          "Brand Identity",
          "Business Cards",
          "Letterhead Design",
          "Brand Guidelines",
          "Packaging Branding",
          "Social Media Branding",
          "Marketing Materials",
          "Complete Brand Identity",
        ];
      case "Events & Exhibition":
        return [
          "Logo Design",
          "Brand Identity",
          "Business Cards",
          "Letterhead Design",
          "Brand Guidelines",
          "Packaging Branding",
          "Social Media Branding",
          "Marketing Materials",
          "Complete Brand Identity",
        ];
      default:
        return [];
    }
  }

  // ============================================================
  // SERVICE COLOR
  // ============================================================

static const Color background = Color(0xFF07131B);
  static const Color cardColor = Color(0xff171717);
  static const Color accent = Color(0xff2FD6F0);

  @override
  Widget build(BuildContext context) {  
    final String title = service["title"] ?? "";
    final String description = service["description"] ?? "";
    final String image = service["image"] ?? "";

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
          title,
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

            // ==================================================
            // SERVICE IMAGE
            // ==================================================

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

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  // ==================================================
                  // SERVICE TITLE
                  // ==================================================

                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ==================================================
                  // DESCRIPTION
                  // ==================================================

                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ==================================================
                  // WHAT WE OFFER
                  // ==================================================

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

                  // ==================================================
                  // OFFER LIST
                  // ==================================================

                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),

                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius:
                          BorderRadius.circular(18),

                      border: Border.all(
                        color: Colors.white.withOpacity(
                          0.06,
                        ),
                      ),
                    ),

                    child: offers.isEmpty
                        ? const Padding(
                            padding:
                                EdgeInsets.symmetric(
                              vertical: 12,
                            ),

                            child: Text(
                              "Services available on request.",
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 14,
                              ),
                            ),
                          )
                        : Column(
                            children: List.generate(
                              offers.length,
                              (index) {
                                final item =
                                    offers[index];

                                return Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    vertical: 12,
                                  ),

                                  decoration:
                                      BoxDecoration(
                                    border: index ==
                                            offers.length -
                                                1
                                        ? null
                                        : Border(
                                            bottom:
                                                BorderSide(
                                              color: Colors
                                                  .white
                                                  .withOpacity(
                                                0.05,
                                              ),
                                            ),
                                          ),
                                  ),

                                  child: Row(
                                    children: [

                                      // CHECK ICON
                                      Container(
                                        width: 30,
                                        height: 30,

                                        decoration:
                                            BoxDecoration(
                                          color: accent
                                              .withOpacity(
                                            0.10,
                                          ),

                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                            9,
                                          ),
                                        ),

                                        child: const Icon(
                                          Icons
                                              .check_rounded,
                                          color: accent,
                                          size: 18,
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 12,
                                      ),

                                      // SERVICE NAME
                                      Expanded(
                                        child: Text(
                                          item,
                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.white,
                                            fontSize: 14,
                                            fontWeight:
                                                FontWeight
                                                    .w500,
                                          ),
                                        ),
                                      ),

                                      const Icon(
                                        Icons
                                            .arrow_forward_ios_rounded,
                                        color:
                                            Colors.white24,
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

                  // ==================================================
                  // GET A QUOTE
                  // ==================================================

                  SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.black,
                        elevation: 0,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            30,
                          ),
                        ),
                      ),

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                GetAQuotePage(
                              serviceTitle: title,
                            ),
                          ),
                        );
                      },

                      child: const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          Icon(
                            Icons
                                .request_quote_outlined,
                            size: 19,
                          ),

                          SizedBox(width: 8),

                          Text(
                            "Get a Quote",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight:
                                  FontWeight.bold,
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
      color: const Color(0xff171717),

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

